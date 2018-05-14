Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpYq3HWpZxDCNPSQMowF9EPxhpNYRsag53DPDD/DtS+lUy/s3f7a98BxTZKj02uViAcXH5L
ARC-Seal: i=1; a=rsa-sha256; t=1526281009; cv=none;
        d=google.com; s=arc-20160816;
        b=Wwmi65ER9YtoAAD0WdgImnuB+jUWqS40ZrFY5czRAs1xXdgAY6xAe5rKjkVCKMcXIJ
         AvS21pMu029M51dLvNlMmqzfUaOVo/pURIUjDTu6rDEe7Vzqc4kpd2FOkoeuo3h2uZWT
         F3j8FwaAYDZgjQRQGw9PRDjgwk38BkMvT7Hdor9QYW9rLBiEpnAFOTVoFWdT1/4E5Idz
         gkUXWAhz9WoY4UzM+UNo9JlYFdDixah+oQ4mUsKEoe5W33WWbTgp+fCFtyXv5LqJDs8I
         RkZ6Ny17S6GzqhMi6ckzVbSQ+mtCjFBF/4ZwwIn1ZNQr7mrknU7BbJRyGkoGKcZtWBWF
         ijSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=SHyiO5f3xrQvix/FjqFlroId5wXajcxPL9vPgm/LlLg=;
        b=wSeNJ4SHbIOLWwqOifq3jv3Q3m+YoF/TND9/XtYkvlyR4YB0zN5iMYsxfBNuKILaTg
         BkeSBkDkFh/aeRtO1ZDH8XBfnnYJbpmxh+M9jLR2MiyXvqDL/ER5blcXLbh8r3GhtrOi
         0lQG3SzL7wHEUDV9vXqigGvK2kXlgP5Q067Jjk2Gsj4w9RWl7aT0+uYQq0BmSE0zxNID
         kx9pgRCabae4Cg7jfaBo5K8KlKg9OYg1+YZFFzWYb6Zru9y3G+icInQTP7/rJXb6xK1T
         l9id45XwCOpaeI7vWSL+QwT80BDNhM7z5e/oT1VTYdmKvJtLkVmAHMFUEyB0ttkm5YbX
         ovrA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=iwNdqD3u;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=iwNdqD3u;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 28/62] dm integrity: use kvfree for kvmallocd memory
Date: Mon, 14 May 2018 08:48:44 +0200
Message-Id: <20180514064817.934000241@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421635763781439?=
X-GMAIL-MSGID: =?utf-8?q?1600421635763781439?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit fc8cec113904a47396bf0a1afc62920d66319d36 upstream.

Use kvfree instead of kfree because the array is allocated with kvmalloc.

Fixes: 7eada909bfd7a ("dm: add integrity target")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-integrity.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2439,7 +2439,7 @@ static void dm_integrity_free_journal_sc
 	unsigned i;
 	for (i = 0; i < ic->journal_sections; i++)
 		kvfree(sl[i]);
-	kfree(sl);
+	kvfree(sl);
 }
 
 static struct scatterlist **dm_integrity_alloc_journal_scatterlist(struct dm_integrity_c *ic, struct page_list *pl)
