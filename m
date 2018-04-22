Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48ofE/hgJbz9ejJhJ8kITE+pC62VvjW2OUW/JOE5MpHMKzOxTKyjsMi3iwnPKOcos/G98nw
ARC-Seal: i=1; a=rsa-sha256; t=1524406591; cv=none;
        d=google.com; s=arc-20160816;
        b=Tih8s6YX4wExHlCK88Qv4rwuNk6zHQaPEmxGu1nCtbBn9ozo+SUIJ0k242WSEc4oXK
         KWpVdSzQTU7qM0Q0VWIaMEGuxJwHoyd5TrIWyuXggxH6Fa7Jk2FYS3YZopT5aJZmJ+Lm
         OBTcMdYrfQlsD61VGhrrqnn/6pTAP1YkrOmqDnbt9HYRldsTdEHkI6wj1Ve80EEPDzZ5
         k9BUZytYOFAvMGa4sj+9MAv8HzgXThqMlytiVpovBrwIu7DoJdp4YAELDblTJV3Srxyl
         1WDeDT8TLMftUY8M4eWAz0W/00qj8wfYnJAJjdaMorVBZsAQIq90nxHR/7WvIIh/BHZh
         HEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ly1JhrHYjsVngXpFKHhS3ITgFAnfaes7QKuFXp4eMnE=;
        b=xwKjgN+8RO/N8+ENOqZFv6/cGbLqab6mGPfBh5kw4as2a/tnHdZ0oWdj8FtXxEtuxB
         31IEE70cGnY+XEw796lcP9mdrMQFOHdQeamjnmKKqDOUpp4dtZGIWzxLSTfKsEQQC7dP
         XnFs4H5UtesMWAhMNYy1PhAFRj17iWMSK0ALvb1dp43UFya3Fv2KnHv+NWzSNOc2yips
         honFwjVIOacP7muh4rQKZNvhfFmtDDjxY1LnD3+lLhXrganAY1c2s4i/2gxndElcrvw6
         8xbMyBHtDpLVK7J6BrSMHHDzQjHsoN2W4FZzS4OPh33bKJHYCYkvLwmmkxEApLoiQCJZ
         Gv2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.4 30/97] usb: musb: gadget: misplaced out of bounds check
Date: Sun, 22 Apr 2018 15:53:08 +0200
Message-Id: <20180422135306.960817026@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454813951848255?=
X-GMAIL-MSGID: =?utf-8?q?1598456165689625967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

commit af6f8529098aeb0e56a68671b450cf74e7a64fcd upstream.

musb->endpoints[] has array size MUSB_C_NUM_EPS.
We must check array bounds before accessing the array and not afterwards.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Bin Liu <b-liu@ti.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_gadget_ep0.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -114,15 +114,19 @@ static int service_tx_status_request(
 		}
 
 		is_in = epnum & USB_DIR_IN;
-		if (is_in) {
-			epnum &= 0x0f;
+		epnum &= 0x0f;
+		if (epnum >= MUSB_C_NUM_EPS) {
+			handled = -EINVAL;
+			break;
+		}
+
+		if (is_in)
 			ep = &musb->endpoints[epnum].ep_in;
-		} else {
+		else
 			ep = &musb->endpoints[epnum].ep_out;
-		}
 		regs = musb->endpoints[epnum].regs;
 
-		if (epnum >= MUSB_C_NUM_EPS || !ep->desc) {
+		if (!ep->desc) {
 			handled = -EINVAL;
 			break;
 		}
