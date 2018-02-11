Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x227Bs6QFR2cOEHHxNa2LOOd5FMyY9x+KHenTg3H2k2hFr4He/jJRNMHUvwigEFZGCACwRMBo
ARC-Seal: i=1; a=rsa-sha256; t=1518323621; cv=none;
        d=google.com; s=arc-20160816;
        b=JQGwhJxpwoYxtQwuJvAgDoDISdUiGr8miHL7bWvUpFs3+0foDnMQYNKGqwL8ALCKAx
         uEqTj4r7DcxZOd+oMZPYU9O9pXLGebQ5b9dvl11ggkIKsSWn+f7V5lU3o1cNqeuSWuKw
         xtlxznFn+Wn3wWlMBMWFNDF13ToklatWASaTz8TeUgeuOGtC5uP52rjJf9VikS3L8EWF
         b5I4LGyIQkf1hbgbbh1iyMsfglSKQcax0WZVNt7gP0hpD6/leFxrt8Uz9+3nLmzbsUnh
         PA3O9LSn5ldppdKpi2iM4SvKFcwdR5USY9ivykzfz0GrdZXNz0BEQJDbiovfrARf+d2o
         Kgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=/wEeb5Pje8iz/njZ3syyAucI9imh6LzMcld1BSjd7+s=;
        b=cGM/Xicnx7PupjgKRs0zruzpQrMIT1coR0F5Do7kv030sM6J4eIKaXNf+NVd82z14b
         wHvPsqMdGQut2gR8EE9J9q/lER9wY6qeyQWfVxlsPYcfSDXNfrS8LfwOHXD5zeM2iGgj
         F30AL3re3Ht6d0VXCJdKLD/G+NWP9TIC6nDVxiuDznZB3bQo4E59sqoaZQhG1azVyxw3
         N2xXMev4ZhE1YAzNtEHQy6gQ3DV+AuRK6goQoGONpGH7zVChtvsiJp3PT0sH7DjXJWTn
         N4gNUxsoDXL+FtJbc6wwCv+ycfgSFlvMybPryeKF+HZUHEJph4qaiCNwK0kcgjFqwFhw
         LeLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Lepton Wu" <ytht.net@gmail.com>,
 "Guenter Roeck" <groeck@chromium.org>,
 "Juerg Haefliger" <juerg.haefliger@canonical.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.533577990@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 79/79] kaiser: Set _PAGE_NX only if supported
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077709129408782?=
X-GMAIL-MSGID: =?utf-8?q?1592077709129408782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lepton Wu <ytht.net@gmail.com>

This finally resolve crash if loaded under qemu + haxm. Haitao Shan pointed
out that the reason of that crash is that NX bit get set for page tables.
It seems we missed checking if _PAGE_NX is supported in kaiser_add_user_map

Link: https://www.spinics.net/lists/kernel/msg2689835.html

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Lepton Wu <ytht.net@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(backported from Greg K-H's 4.4 stable-queue)
Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/mm/kaiser.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -189,6 +189,8 @@ static int kaiser_add_user_map(const voi
 	 * requires that not to be #defined to 0): so mask it off here.
 	 */
 	flags &= ~_PAGE_GLOBAL;
+	if (!(__supported_pte_mask & _PAGE_NX))
+		flags &= ~_PAGE_NX;
 
 	if (flags & _PAGE_USER)
 		BUG_ON(address < FIXADDR_START || end_addr >= FIXADDR_TOP);
