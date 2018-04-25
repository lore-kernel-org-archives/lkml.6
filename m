Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZqQlaJ8ifMcizIPlEXxRo4sAUTOFtTL4V1WzLpD49TToyfj9y4/HJ66ZpaJv8efA9W7Iuxu
ARC-Seal: i=1; a=rsa-sha256; t=1524652926; cv=none;
        d=google.com; s=arc-20160816;
        b=TqgMvBDgod8/F9wyW/eFE5qxGW8UKLlkFZbFXIbpM+QiT2CSwFSlPlj3BPFFkJ0yPq
         ++ChbFrkjgmoM1JmIjVrFTJJNSDFy6TGGDSaU8eDOze40nPWnwaQkflESi5G8+TU1cHd
         Mi8rRvfOscRPd//GNYhFc5/0iGnb8ipie2C2eMdevxbJeTsVbYosVUgtDT4zdb1McDuS
         Xn6HB+wSsqoR5rYlHSVArWPKW6ESlXhnIn5DLms+JWctm3ikkV5Dtaw4ION9eGVXtezk
         f53lRM94xZ3riWKKVNXFgWMrHfSg6DRmDlr8Oz6iS558cprZaohReWXkcT6DsQ4Sg4g+
         s3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=E59AiQf9YqzO1+EoU3wvyqA2UlzHBQZxK91wNJz+VIA=;
        b=ohFmrQclOByk880woIo08RRPgDE3fW0pyU3p9Q9TFDZsZMnWCGQoul7M3xcbWBYO6j
         O2R8Oh72UOVAnzQz7nhZAj8XXu+6dsrnLz+kHO4ZNEDQ+Cso5HNOpSKfsbHhLLr2lTyY
         vZOQIkySp6Rt7mbSqmwAGmO8ZqD0BHorDwh6W/86eOe+2UqDHuAT2sI0/0flXxTcdBmf
         ysgNQoSlII8oQTfGOyrRblxfSsFs8ZPhNspk79cvP3HW7cbpmw+sR8eZieDL0h8d4hwT
         NJYd3kSXcOz8q426+TFPihTr4gWUFIAeykWGicsqbT2yBJflASI7RIEmC/I9LEslF1+o
         EQvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael J Ruhl <michael.j.ruhl@intel.com>,
	Alex Estrin <alex.estrin@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 121/183] IB/hfi1: Fix for potential refcount leak in hfi1_open_file()
Date: Wed, 25 Apr 2018 12:35:41 +0200
Message-Id: <20180425103247.294705514@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714467201382925?=
X-GMAIL-MSGID: =?utf-8?q?1598714467201382925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Estrin <alex.estrin@intel.com>


[ Upstream commit 2b1e7fe16124e86ee9242aeeee859c79a843e3a2 ]

The dd refcount is speculatively incremented prior to allocating
the fd memory with kzalloc(). If that kzalloc() failed the dd
refcount leaks.
Increment refcount on kzalloc success.

Fixes: e11ffbd57520 ("IB/hfi1: Do not free hfi1 cdev parent structure early")
Reviewed-by: Michael J Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Alex Estrin <alex.estrin@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hfi1/file_ops.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -191,9 +191,6 @@ static int hfi1_file_open(struct inode *
 	if (!atomic_inc_not_zero(&dd->user_refcount))
 		return -ENXIO;
 
-	/* Just take a ref now. Not all opens result in a context assign */
-	kobject_get(&dd->kobj);
-
 	/* The real work is performed later in assign_ctxt() */
 
 	fd = kzalloc(sizeof(*fd), GFP_KERNEL);
@@ -203,6 +200,7 @@ static int hfi1_file_open(struct inode *
 		fd->mm = current->mm;
 		mmgrab(fd->mm);
 		fd->dd = dd;
+		kobject_get(&fd->dd->kobj);
 		fp->private_data = fd;
 	} else {
 		fp->private_data = NULL;
