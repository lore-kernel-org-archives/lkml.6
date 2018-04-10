Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AIpwx4/LLmzw9sk2LiBGW31Yaa6811zFpaQRfHxzwfc6I4JY6oOFH1I9Izu4iLRck7O21Y7A+PyX
ARC-Seal: i=1; a=rsa-sha256; t=1523366515; cv=none;
        d=google.com; s=arc-20160816;
        b=j0s0jlY8SnnLagVndmodHm+8z23lQgqshP0N3mDtqQ31gI0yRUgbrKg2vJY83X9rRX
         a2oU31EOmMjszFhzNuWKujgBrh9gKkqfwHC6ea3CuqPQmOasovwuzi2JPNvOZtEy/AjE
         8n7p/a7oyp6h3yU2eyCguPV1S5QnAA/UvMHOL+M1XNl5upH7fy0/4blFJMWVAh92F6A/
         jeEYuZ8/v7R/BTGvkUr52q4oemyiGZOl7t+XD/lpJtAcCUOqVCvOhLmOvo0yd8errkH3
         FMMne9etri8U6bdL6qUeiXeKZmu4ZYKsWx1dQjBM9gu9qiSst4p+kI6MXfyXzgN4CZe9
         AUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=TdhbR2f7S7SezOxwtHJS1bqd2WYFPV8H5deaANSkiXI=;
        b=EwZN5f+c8DM1vpy0PZWSYNU0vhV9i0TOJzoZ6ODpf17dLQRK372yPlC0eqhwsw/9DS
         166Lou9S8bNteSSD6lXPMKnD3ItPn9KoqPfWlm7ULG9JdcncBmn7dr8j25WsIjaAeFcy
         oy+4pPpRLEH+x2WdCzmOzPMZSLdoDWiyG4hGjIMKbYQ+zk0gFJGGTVK2FUdzmYm+yYDB
         cDkBFay/HzkSyu/p0CLTkJKmJEz/MUDqykuVbkPa4sirELQUAVJ6erbfR56iniU+CvTl
         p0QFirLL9urdfVSoiorSqzzU2/AE0DfdqdUQLMKEhOii8BcDimXSwCSHXFtxKXueaHkI
         ae6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:19 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:110:4::f00:19 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Adrian Salido <salidoa@google.com>,
	Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Todd Kjos <tkjos@android.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/4] ARM: amba: Don't read past the end of sysfs "driver_override" buffer
Date: Tue, 10 Apr 2018 15:21:45 +0200
Message-Id: <1523366506-19832-4-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365567393442671?=
X-GMAIL-MSGID: =?utf-8?q?1597365567393442671?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When printing the driver_override parameter when it is 4095 and 4094
bytes long, the printing code would access invalid memory because we
need count + 1 bytes for printing.

Cfr. commits 4efe874aace57dba ("PCI: Don't read past the end of sysfs
"driver_override" buffer") and bf563b01c2895a4b ("driver core: platform:
Don't read past the end of "driver_override" buffer").

Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/amba/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 36c5653ced5742b7..4a3ac31c07d0ee49 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -84,7 +84,8 @@ static ssize_t driver_override_store(struct device *_dev,
 	struct amba_device *dev = to_amba_device(_dev);
 	char *driver_override, *old, *cp;
 
-	if (count > PATH_MAX)
+	/* We need to keep extra room for a newline */
+	if (count >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
 	driver_override = kstrndup(buf, count, GFP_KERNEL);
-- 
2.7.4
