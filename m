Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt1DQJk4DT6HnWO4XoPO81OagaqNpyiMzBYjE24eiCP+2YpY3x9/bN2TsyphZxwOpSqhTZw
ARC-Seal: i=1; a=rsa-sha256; t=1519411043; cv=none;
        d=google.com; s=arc-20160816;
        b=0Coqp+lqaiNN/Lz/mfbc/AMpsefwXqiC/Zx1ink51I405qqexpuL2Z3SCcZaPoPKHk
         CyT5MINTqZGesVUeDpYEdmUCPPpYdRhdBLbAhp/jFOmm9BZVosn/zvMYN42Rs9Z4+0xR
         lrku5yMtvDQHnPz/out+k4zAkr52wil4Gkrr5BD6v7J9iF/lZWMSb/u7e1qwewQ4d4d+
         hIVD7Z7jMUdLT76vTa6zC09ZvR5MPM8Tb5you2LJBNyGrx3E1tJaKqdm08Z8gDCJcNYi
         32d3r00Cpjy+XUYeiZxRIQOhaloa76KFtOSySQWbEz5hcKqFXZDOVw8QJNyngxHm50HB
         BK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vH3l9/jq+bGCArAJGIoiPj4OZUQRHkKKhIJqwYC6hSE=;
        b=vs9pCQ8fsHdIKfNrkobr0/UvfGsDSTWBXMXeosEDgX6Mi5EIQmxnNtQ80sNzMg92ux
         B0Q0YCPPxRoSbbrJf2odpsEwDR5zCJbTXL4pbmi7o50S2fGDwOLfZNpqMNhomYMWAjJX
         GQlZE/ODRTjVGdBh87MElSXfFxAn/BYdDBzw+Woo9i1x1LKcchH76c6BdQ7D6x6VTroJ
         2WJFC/yev6UMSa2zEKbG+Tb958Nvc32Xo7YVWi6Du7iQvcPJXG7mB9oiap6Rz9OyGWG1
         Aclfo+TS8033gG6ua0D32YgBQSx8wsG8u+PHRAE6PlMhWDtbMOvdCgm5Jni9MEzJim2k
         Faqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 101/193] tty: hvc_xen: hide xen_console_remove when unused
Date: Fri, 23 Feb 2018 19:25:34 +0100
Message-Id: <20180223170341.829892060@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217954429418283?=
X-GMAIL-MSGID: =?utf-8?q?1593217954429418283?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit e36ae3439936e13c33f5841c7c2c1a9875acbb6d upstream.

xencons_disconnect_backend() is only called from xen_console_remove(),
which is conditionally compiled, so we get a harmless warning when
CONFIG_HVC_XEN_FRONTEND is unset:

hvc/hvc_xen.c:350:12: error: 'xen_console_remove' defined but not used [-Werror=unused-function]

This moves the function down into the same #ifdef section to silence
the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/hvc/hvc_xen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -323,6 +323,7 @@ void xen_console_resume(void)
 	}
 }
 
+#ifdef CONFIG_HVC_XEN_FRONTEND
 static void xencons_disconnect_backend(struct xencons_info *info)
 {
 	if (info->irq > 0)
@@ -363,7 +364,6 @@ static int xen_console_remove(struct xen
 	return 0;
 }
 
-#ifdef CONFIG_HVC_XEN_FRONTEND
 static int xencons_remove(struct xenbus_device *dev)
 {
 	return xen_console_remove(dev_get_drvdata(&dev->dev));
