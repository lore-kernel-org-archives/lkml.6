Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtLOwNWttqAGuHJ1FxWE6MgDMfpuQVU2+ApGKjeZUK5YMuZI4j3hLxbJX3Zk8/oSg8ZklDF
ARC-Seal: i=1; a=rsa-sha256; t=1519981474; cv=none;
        d=google.com; s=arc-20160816;
        b=hqnDDIpqFfemnIzVcxZUoVQMSOvUkx0dsfxlUANuX5z/Ll60oWQszQ+pnrN7eDYuSO
         T96gQsMTypeRkyy82A6dzDbK9+EIGQU0Zuv+S89+k7C0Xqf7xlZm3NMxYmW3XNMA8zFf
         utF0I2Ym7Za5M9eNETen6JfoFwbOwRdaLDtT1sStPHqYe9auFQAwZ+yOSRPZRA8GX/Tg
         5AO4I1usqlvyO8Wh70taQc/kBX8vSFqONI7XQRbrfQufp+TdzldUgSIFzOAh8r8lawjA
         5sSnGJUu5pTo6t6dYjUMi2X51eE+uKoccoF8S5wWfRpJzgzJBd+MuAJs4zurQ4plB1Vp
         ugvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CuCZo0tHvrzb+AiZlQX19BS3EJjYnlsi13B9oHt/pL8=;
        b=hukb5c+jpD13NtmrnABeXuo/7PRbE22Q9kpZSbZLk9qY42aG5VWM0+lzsibOfcYvE2
         HJ3kCR4dab6JL2FNiXyofYlEUxWWL4tN/xrnLuWP036Jhl/biJm7P/A74pC/i95qO9PA
         nNZ0ooimEqb4bN8N/XVkihm7KS7C22m/x9hmwp/FwMvju17tfCcMQNYJH60Q8rYtuN7l
         xzlPS23OrjZIgxO9CrlM4gHr4a8E0PRuefwXsBrtLslTHHx4nH11TMCo/nUEkjPD7hoA
         B+WKs0BlknA0wp6jJCoyk55Dmmyaddc7QT8brCDtemAO2M8ORZ25DOCJ42uzygk2wkxQ
         Tv1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikolay Borisov <nborisov@suse.com>,
	Liu Bo <bo.li.liu@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 067/115] btrfs: Fix flush bio leak
Date: Fri,  2 Mar 2018 09:51:10 +0100
Message-Id: <20180302084506.576080973@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816094854723427?=
X-GMAIL-MSGID: =?utf-8?q?1593816094854723427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>


[ Upstream commit beed9263f4000c48a5c48912f26576f6fa091181 ]

Commit e0ae99941423 ("btrfs: preallocate device flush bio") reworked
the way the flush bio is allocated and used. Concretely it allocates
the bio in __alloc_device and then re-uses it multiple times with a
very simple endio routine that just calls complete() without consuming
a reference. Allocated bios by default come with a ref count of 1,
which is then consumed by the endio routine (or not, in which case they
should be bio_put by the caller). The way the impleementation works now
is that the flush bio has a refcount of 2 and we only ever bio_put it
once, leaving it to hang indefinitely. Fix this by removing the extra
bio_get in __alloc_device.

Fixes: e0ae99941423 ("btrfs: preallocate device flush bio")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -236,7 +236,6 @@ static struct btrfs_device *__alloc_devi
 		kfree(dev);
 		return ERR_PTR(-ENOMEM);
 	}
-	bio_get(dev->flush_bio);
 
 	INIT_LIST_HEAD(&dev->dev_list);
 	INIT_LIST_HEAD(&dev->dev_alloc_list);
