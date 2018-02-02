Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224UQyTS8/XF3r7vwHDeLUDqKppmjKh4EnfP7pLxKcOfKZ+Huqtki8qOIFlJXDF1QTG4vrNi
ARC-Seal: i=1; a=rsa-sha256; t=1517591790; cv=none;
        d=google.com; s=arc-20160816;
        b=ex6OxPmys8uLR71R4pj55B8fdzTqUxIqtmNdhc1NGEeNNkhVKgZB6xxZhsOFEDYq8h
         skFYOW7+mN5sj8hYBnPCpYhs+UbRCsYVro8pf7A7a3z5HAOTd8bGKx/JxYz5mUo2Uus6
         FUcYwTcZ37esNjUVwOynBdVZeaetrhzLHbtiMDJUV1YmNNsm6FNR4pifGEcYWqvsdV9/
         woo+6zmQUaYTHJ8gzbDUXY4jyj1gzgeI/xJc0YXfKrfgO0qh4p2qPvO5izJSLSKllKZA
         I1XDNu+Hoj/LoHobtTNbdV7fYAw7OLwTCS5LjO459DcMs98oJYNYAoCdVoPWbuOJIARp
         rs5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K/jI9ZhVY8ZneEQVEnPhi2K2igNfdjCfavVVraIaVao=;
        b=bYc4OW7JUVUGtYXl0rMAa3BRQobjMoyjmfQm/iIWK+SeLi10V92QmzYG3fc9ZtsGCg
         F8GHC/CJ2X5bg95yRTXhcqoRejFxkzP5I5QH+GWErMODzbX/Yx5+ml+ovCApR253+KqT
         rd0lIyQq6GXVLcV/PJ3Cn3zWwBsH1hHBtQ7Rmzn5sdez6MKRRAC3QJgck1zN+x2vQc0j
         z62Xt7jHccP7JF5DAvFYYMPFZr8zIO3A0Y0fJEgWhcuOiwa5fCA0aveBIxGDj0fJLQKc
         8urlbi6Eh+gLRBpEvfYZEjLYdQBSp918IJkblrTjSJJs2MwJbkmJhQNopdq0X7y1gUw+
         x3Yg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH 4.15 44/55] mei: me: allow runtime pm for platform with D0i3
Date: Fri,  2 Feb 2018 17:59:02 +0100
Message-Id: <20180202140830.404461699@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310183968671557?=
X-GMAIL-MSGID: =?utf-8?q?1591310329584130023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Winkler <tomas.winkler@intel.com>

commit cc365dcf0e56271bedf3de95f88922abe248e951 upstream.

>From the pci power documentation:
"The driver itself should not call pm_runtime_allow(), though. Instead,
it should let user space or some platform-specific code do that (user space
can do it via sysfs as stated above)..."

However, the S0ix residency cannot be reached without MEI device getting
into low power state. Hence, for mei devices that support D0i3, it's better
to make runtime power management mandatory and not rely on the system
integration such as udev rules.
This policy cannot be applied globally as some older platforms
were found to have broken power management.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/pci-me.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -238,8 +238,11 @@ static int mei_me_probe(struct pci_dev *
 	 */
 	mei_me_set_pm_domain(dev);
 
-	if (mei_pg_is_enabled(dev))
+	if (mei_pg_is_enabled(dev)) {
 		pm_runtime_put_noidle(&pdev->dev);
+		if (hw->d0i3_supported)
+			pm_runtime_allow(&pdev->dev);
+	}
 
 	dev_dbg(&pdev->dev, "initialization successful.\n");
 
