Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227lLozrDZQNungRxfboOL23+RKzVO3/aFihbcccJ6G+ZkzLJnHwvkL50En65H2BA3jD9nyT
ARC-Seal: i=1; a=rsa-sha256; t=1517591149; cv=none;
        d=google.com; s=arc-20160816;
        b=xAV+U3oMH2IoUm35hWHIBYFJ8hLLfA54e0MklBeYGuGeeII3QjHP4+4nAgiWHVzGiz
         kKXCXKCEZRoinBBE7dt5/TmsjslVqGXaHSh3L4E7Pi6pknqYH3HNGLd5gC/fato32RXm
         3nS5p4ngytJLESDJo7jsp54CVH8HOldNs3aOho51YdjeZUNrEJmphubwHAGazX7q8N54
         Vq0WSzpmKOxdDkFY0fP3M8hUC2kaiJsGmqP9CRKdb8ONUpzP9v4iI9gHz6Us13AICfH4
         ZTm8QgAYTxZJBoIPwlHDddcxumxpN6hBO+BsAxrw4vRAe+uByWg4zB5A000oP+/oo602
         4IUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xb43s24Xe1qtUraR/Vn6R2jirYsqnb6Sief1VM4NZ8Y=;
        b=ymOoMJwmk1sIsF/D8Hf2ogPoIhKtT54YQWoSugRbSgUawWqyxQ974bhkzM6WSZWaZa
         bLQcL3xasabYS2EOloPCeFp6zqU+zsIAuTVkh9C/ZcIsfL4jOUWFGTYz0dfQajCMiRKh
         8jPnDlZFcURH6V7HZF0xTn+NI3YtUz7surE3EVoF/yykshjXUDuP6nTJxzwVrWza9A0P
         iK5QHGPL7r/Hq6j6urWIuA8fZYzYTP8M8lhgyasFMhyCcFR3xjH5WdGxn9wqdpj+EiFT
         0L7zYbC0MsFzZt0IGtkGe8HmG4ioDP4UT1Kk1k7qjekH6rSE468zkDOC+R7AN4OdiPVn
         SmEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 68/86] usb: gadget: dont dereference g until after it has been null checked
Date: Fri,  2 Feb 2018 17:58:28 +0100
Message-Id: <20180202140828.936895918@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309400693081740?=
X-GMAIL-MSGID: =?utf-8?q?1591309657622272143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit b2fc059fa549fe6881d4c1f8d698b0f50bcd16ec ]

Avoid dereferencing pointer g until after g has been sanity null checked;
move the assignment of cdev much later when it is required into a more
local scope.

Detected by CoverityScan, CID#1222135 ("Dereference before null check")

Fixes: b785ea7ce662 ("usb: gadget: composite: fix ep->maxburst initialization")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/composite.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -150,7 +150,6 @@ int config_ep_by_speed(struct usb_gadget
 			struct usb_function *f,
 			struct usb_ep *_ep)
 {
-	struct usb_composite_dev	*cdev = get_gadget_data(g);
 	struct usb_endpoint_descriptor *chosen_desc = NULL;
 	struct usb_descriptor_header **speed_desc = NULL;
 
@@ -229,8 +228,12 @@ ep_found:
 			_ep->maxburst = comp_desc->bMaxBurst + 1;
 			break;
 		default:
-			if (comp_desc->bMaxBurst != 0)
+			if (comp_desc->bMaxBurst != 0) {
+				struct usb_composite_dev *cdev;
+
+				cdev = get_gadget_data(g);
 				ERROR(cdev, "ep0 bMaxBurst must be 0\n");
+			}
 			_ep->maxburst = 1;
 			break;
 		}
