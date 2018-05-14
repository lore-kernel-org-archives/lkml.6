Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpOQ1S0JrWRYPjBoknc7i0DWDTW2RFJ0BcW5h2qGGgiS9P5AwVJq0YozHePkCTEhxz0C/4O
ARC-Seal: i=1; a=rsa-sha256; t=1526281133; cv=none;
        d=google.com; s=arc-20160816;
        b=kGa/sUQGHeImzdQMlXHN2cvz8hf18Az6gcSXv8E+8XyO2JULMryJ9sKPytxfJ2OEcA
         OdgZfSx3vRIGS3CLojkm9nqid4eEqVmM11BuN8jFs7q30FP4Jbdm3UQQB5LDlyFZV5Ot
         ICaZAnUSxW1gf/AJl9PDE7fXsTAjarK6qoc7iwc2NzhXDHRROY3BItVA0pXQslGQpDUe
         0cO/VlbmMhfcbaEYOqbb+TJ0QsjOlyYuPdGQNBWTGVi+L70VFHbDvkP/S4pBk4PdgCiU
         LqBbOXQ7K/qEK7praL9H0iP4gMTZAMfeirPGoZafrLlvTm8U5HmgT40rvuhFbnl63bMw
         I23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=DfNd84cZK7g/1hqSDiIcO7Nx7akfoX5R2O21l+XTTkQ=;
        b=z1Qc5Zldrne6e+CBQMCki39MaELsl6NWWnsq+EZ0vLRcC65AInWGPv4u6XBCOD7N7x
         Ixg2gadc9H/hpa8PS0ynrOegd8fxbgEZUTE1Culs1cBNxbX7KmdBdfImBc845uQJt+wl
         IpeRiiwANZRDPQqL4BcBdJDyDzMcbjT2ulnFtCOjzfrclA8MMWqKF5+YXKV2L7eO7Gmw
         oum1Ah6hgLKv5rBU6Ladv7g8JVNCSZ30A2I+2GZAe/Jq5lljSLfiH8CwaxjiAD3Z7iYm
         hFvb5R4FWS+C++aUhdsjtbSNEOhoXSqakwjDxyhiYnQsd0sJHzO7GBNo56GLZ/7Ty26Q
         fZjw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=W8YhqZ1n;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=W8YhqZ1n;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.16 29/72] dm integrity: use kvfree for kvmallocd memory
Date: Mon, 14 May 2018 08:48:46 +0200
Message-Id: <20180514064824.298486484@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421635763781439?=
X-GMAIL-MSGID: =?utf-8?q?1600421765787615700?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2440,7 +2440,7 @@ static void dm_integrity_free_journal_sc
 	unsigned i;
 	for (i = 0; i < ic->journal_sections; i++)
 		kvfree(sl[i]);
-	kfree(sl);
+	kvfree(sl);
 }
 
 static struct scatterlist **dm_integrity_alloc_journal_scatterlist(struct dm_integrity_c *ic, struct page_list *pl)
