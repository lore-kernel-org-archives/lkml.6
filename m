Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224g5t6GcD81adYNlwN6qHvGhG837DHjic6IXJiQfVWvoE3WDCkiqjincDpgJsHZfTw7/vAY
ARC-Seal: i=1; a=rsa-sha256; t=1517591782; cv=none;
        d=google.com; s=arc-20160816;
        b=rRf8T5r838okAlPqizZck8CTaMPkokkIzNDl+9eXJdOnyPOEchC4BPmMt6bvJy4kMC
         dKm+AGDIlGOuFa3nnomXlWnXjSNB5wLA9wZf8mGb1OwE31vfsYbZUn1sUC3av5CdqG1W
         txWxb/h0ffjItInj4RQA6sgV8iJiAvmpJ2kbDzP7QRn7o8PRkoTM+7JTF9BTOfy2V/qS
         ZcYIZ5BL3pYyzTeWyAneP2vRHlgSyhfBg6I0Oq/56KeXfLRu3iQTsISS0iF97W8ACFdm
         4W6ufXYi5KYL70po5VkI+AK+m64e/wOWGNOCfODM/imjqxzmSPvt0t9q9VKm4nGXLptw
         yR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZV5s4Mly356puXr0dlF1pI8kbSQ5alYQvHiDgp1QQAc=;
        b=Ky6njVQ+sVlnGlK7LLTAlWwGkU0Ad6h3N/zS9/w2ByznDa/XljJdUUxPW4DV9Po4Pw
         FrFJTRVVerkYwxUIa9RG3CxHtf6xRhDJTV0FuvmcBAzxYLkKQ1OJtNnuVpmCnzJ+W3TH
         AZpPfxAgBUVpXHTvSd4OFmMkRzBluMV+dZfXiXzbXlIgCFIVXtWQaHhXzvJgqjNY5HwM
         PHC5m5Q7cHKpRjhyzSaz6NPAtytVRt1Blxq6cFdBQQgRKgpvHuGlNmWoqV8Wg4GRVItH
         7Ftqx/czSNNjLNYoJ2UvV8fSnoZXITf57AIzmIELyBrQJlb03ETqe5Ov9pJqvSyfck51
         vEuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4.15 41/55] usb/gadget: Fix "high bandwidth" check in usb_gadget_ep_match_desc()
Date: Fri,  2 Feb 2018 17:58:59 +0100
Message-Id: <20180202140830.145557205@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309737270542005?=
X-GMAIL-MSGID: =?utf-8?q?1591310321372810412?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 11fb37998759c48e4e4c200c974593cbeab25d3e upstream.

The current code tries to test for bits that are masked out by
usb_endpoint_maxp(). Instead, use the proper accessor to access
the new high bandwidth bits.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -912,7 +912,7 @@ int usb_gadget_ep_match_desc(struct usb_
 		return 0;
 
 	/* "high bandwidth" works only at high speed */
-	if (!gadget_is_dualspeed(gadget) && usb_endpoint_maxp(desc) & (3<<11))
+	if (!gadget_is_dualspeed(gadget) && usb_endpoint_maxp_mult(desc) > 1)
 		return 0;
 
 	switch (type) {
