Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtkl44B7s8aqcCd8I1Ci9k1b+FDUk5dhSLQT8KRPhCDyQlIJx7AxWTD+kKplT/lP/vuMO1n
ARC-Seal: i=1; a=rsa-sha256; t=1521483540; cv=none;
        d=google.com; s=arc-20160816;
        b=ssjAAEj0A0utPkcs+qRxe4r5cNkgRIyCCI6QU+rmX9vD7srCPYbmA/+j2xHsLSk8nG
         tR5eWjBzFw9ILuOTgLPKstuQDVXQinErrCQZAsE8jY91YgkTeQYpMN5PZf+ENPSXaWdX
         YlaUrH+VTSBr1oA67IVUGNvKLpaFrbQ0dX5kEWfJGbnzLY9yz7iQcm/SEk7G0Yyd5W+v
         /axFzqzul2qnGwvJSpG/74DNdT8V8CeQJOR111GVOfEtYIAllY3MdlfSHmBTjcKWnnzB
         yTA48uSDv4g8jEpy5sENOjxgGRl0q3isw565SQ98oUkRrdeJkOK41BH7FQ3udY2M+GvO
         ulkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=23ophyPt2yNy0wtp7ZeZbZlZO5R7nPFzMJNHHlBlf7g=;
        b=voGNL15re4u6fL4L1HZd86zaU9yCcpqLMFlM+9o80RijgN9qk83D59pARUeKpkZNRz
         zahWlFsELpqE67wO7aB7gxusALMz+Mq2z1qw11C6snMdVgshxJXF5b/iaDVVvwtOb7Ch
         ISO3GBbOA/6SmoN+hgewLwQGKbe+hjHFB2mYpaEOVLqPTx2d+rQiMFS45H/VLnfndwNB
         RzZUvaMWi3m91vn8y2LAk7wk0etsJ5Jq4GMjWvOUuuwNM4LYNV1yn9hQ284CodDnYm0d
         iYLOmrL88wyz7w/FiPra1YxJ67fnCh3xKmRVIUZlEj3QtMhPom6Jhc2wm8Z5qhuW80BF
         oorQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Valtteri=20Heikkil=C3=A4?= <rnd@nic.fi>,
	Tomasz Kramkowski <tk@the-tk.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 006/241] HID: reject input outside logical range only if null state is set
Date: Mon, 19 Mar 2018 19:04:31 +0100
Message-Id: <20180319180751.440434339@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390526332956938?=
X-GMAIL-MSGID: =?utf-8?q?1595391124425601807?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Valtteri Heikkil‰" <rnd@nic.fi>


[ Upstream commit 3f3752705dbd50b66b66ad7b4d54fe33d2f746ed ]

This patch fixes an issue in drivers/hid/hid-input.c where USB HID
control null state flag is not checked upon rejecting inputs outside
logical minimum-maximum range. The check should be made according to USB
HID specification 1.11, section 6.2.2.5, p.31. The fix will resolve
issues with some game controllers, such as:
https://bugzilla.kernel.org/show_bug.cgi?id=68621

[tk@the-tk.com: shortened and fixed spelling in commit message]
Signed-off-by: Valtteri Heikkil√§ <rnd@nic.fi>
Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-input.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1156,6 +1156,7 @@ void hidinput_hid_event(struct hid_devic
 	 * don't specify logical min and max.
 	 */
 	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
+	    (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
 	    (field->logical_minimum < field->logical_maximum) &&
 	    (value < field->logical_minimum ||
 	     value > field->logical_maximum)) {
