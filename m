Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpfrDYhkjv11xGMYIlQNDtnVDwjDtCinqEsj+Npsm1Ui+GEvJqbXm6oiUA0vJhN91gGiDck
ARC-Seal: i=1; a=rsa-sha256; t=1526280649; cv=none;
        d=google.com; s=arc-20160816;
        b=nCqrwFaS9uBsapoFwflKmu6KSbV/vl2ZbVNdHZQfL1BrNQ1CYfIEmYsyo9qtg3HjYV
         fFvY0ydttiD0C90w4wHF49kuEBYwaEd6XmEepUMteuywaVuLdML6kKAXFncBflsW7DNT
         X5roeT5lAliQzW30SgCiaKAnrtzvfNJz2ZBx7hmhrWYVKTnx+YtwnfoHRuJC+kYoNaip
         +ZhxQ12C5ivzubAdyrzRu0GpXSO7yzZ4wQf0eVfSfSb1afmVQf1CwWTVlZNM01ahOiuc
         LdZuvegaLoEmtc2WTNSuR0krnII7d0hNPn57gVXfemMZzxvZwoSYoPv3DUw9o/BXCSxF
         jf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=fZVXLC3VDJls9S/qd7Jx3lALqc0HkS3A4mf+JG7aeMw=;
        b=RpwVue5p1li8qQMovw04PX15mqGcWt7UK4qwL6wMJf0p9nKaZqZazJIlwsOLCQZG/c
         HGRJcNxE+JrFCVAsKHAP6454zDgKWpJpBwA9WlRAeyQcrY+KFtq9Uzxy35rf97jcsY+U
         cAIdZ0Oexx7B78h6aYce0EQJpHcg89Re2BfV33d/MnLM22ngqK5SWkMFZ2UepJLqwPpC
         o0022WvxKMm918ozQ3PvILzjydl/JpOu7anO3cTnLwsbh/n0nCjg4YGdJcx0VaZUAKni
         dt6fRr2qTtIQl2tJIbBi6CvEBD7MslxK2iPY9lcta6W4sdnzfCRUX1NUT+UPXZLqdvbW
         9XUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FAC6DATL;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FAC6DATL;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3.18 19/23] rfkill: gpio: fix memory leak in probe error path
Date: Mon, 14 May 2018 08:48:48 +0200
Message-Id: <20180514064704.856469248@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421258890786882?=
X-GMAIL-MSGID: =?utf-8?q?1600421258890786882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 4bf01ca21e2e0e4561d1a03c48c3d740418702db upstream.

Make sure to free the rfkill device in case registration fails during
probe.

Fixes: 5e7ca3937fbe ("net: rfkill: gpio: convert to resource managed allocation")
Cc: stable <stable@vger.kernel.org>	# 3.13
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/rfkill/rfkill-gpio.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -134,13 +134,18 @@ static int rfkill_gpio_probe(struct plat
 
 	ret = rfkill_register(rfkill->rfkill_dev);
 	if (ret < 0)
-		return ret;
+		goto err_destroy;
 
 	platform_set_drvdata(pdev, rfkill);
 
 	dev_info(&pdev->dev, "%s device registered.\n", rfkill->name);
 
 	return 0;
+
+err_destroy:
+	rfkill_destroy(rfkill->rfkill_dev);
+
+	return ret;
 }
 
 static int rfkill_gpio_remove(struct platform_device *pdev)
