Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48VbJQloBsKO5V+A9/W6wD8gJQXiN0rzEMg8RXx2c4IrS7TJtwp750f9s58wUZ4ecLFiBrj
ARC-Seal: i=1; a=rsa-sha256; t=1524406648; cv=none;
        d=google.com; s=arc-20160816;
        b=yt6cGfI8kGjWJ9tBC+UBYzXhMl8w1CQMlcx8Uk3L7WvyJmo2ZYl5DsahvNjHr4VkNY
         LZ9LgAgq8lOc8kbtYcfKPM9v4bH0DV/95jzFZAFPov+tljFshVh7Xr2mOYp9wgX7yDjY
         faoSg21huSDTwJNepyk19Cjticzwbd3yn9W4sTokRy9BrIDG1pKHfuGn84DfeHXwMylR
         2qhTlr0VRbmbUOSMpLzLI4hRGC5/f5zP3b+r/5bbEH880IbiPP/Cw6HyDlHtKSuw2dNo
         HCn20GtIiiYGZMud1YTd4dnPa0aHIWCzRwLDkTXXG+ytDt7/covs9XBZHlMZvIM6axWz
         7emQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wp5E47IF98bLYNRCMPVcSvMZpvUFVuoPZWCjufXTzkI=;
        b=qlUcYl7navc+zWArzwZ9ycvKQFonZWGDJ/6cUPjbHnPRFnAbpKcWHlrF+Kn73jLCrQ
         ifhj9CAGQhcGrC1EIk3LXcFU7LjRDnicDL12Amw5uEcfEy0A5O7Lkntf7bYXNRy9SiYn
         /xGSuC9ZBd55NSf7lXsyYO5IfyaSrKYf+jLCkxFuLbTBq3QYGZpum8hTxDH3t7T8b0aU
         UZJVxSL5j+sbM6qJ/UcfB4o6BUjjKiMm8AiL1QCWow/rRidV6FneWOUPXUs2wQABaMOS
         ylAg72pW4EfgT/31vFTKoTdz0vCR68aBqap8Kka+/ecRb6qG2sZPALkDhkUUdTPOfKm5
         Zqdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+a67bc93e14682d92fc2f@syzkaller.appspotmail.com,
	Roland Dreier <roland@purestorage.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.4 52/97] RDMA/ucma: Dont allow setting RDMA_OPTION_IB_PATH without an RDMA device
Date: Sun, 22 Apr 2018 15:53:30 +0200
Message-Id: <20180422135308.188699684@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455058285314563?=
X-GMAIL-MSGID: =?utf-8?q?1598456225288960977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roland Dreier <roland@purestorage.com>

commit 8435168d50e66fa5eae01852769d20a36f9e5e83 upstream.

Check to make sure that ctx->cm_id->device is set before we use it.
Otherwise userspace can trigger a NULL dereference by doing
RDMA_USER_CM_CMD_SET_OPTION on an ID that is not bound to a device.

Cc: <stable@vger.kernel.org>
Reported-by: <syzbot+a67bc93e14682d92fc2f@syzkaller.appspotmail.com>
Signed-off-by: Roland Dreier <roland@purestorage.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucma.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1230,6 +1230,9 @@ static int ucma_set_ib_path(struct ucma_
 	if (!optlen)
 		return -EINVAL;
 
+	if (!ctx->cm_id->device)
+		return -EINVAL;
+
 	memset(&sa_path, 0, sizeof(sa_path));
 
 	ib_sa_unpack_path(path_data->path_rec, &sa_path);
