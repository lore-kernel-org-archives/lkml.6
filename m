Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtgHKvrqpYSqM1nRiSOg3JFJKEq9oYxW9B9N0de/S+GliRek8+OFALSXv5QuSkqcev1vm/u
ARC-Seal: i=1; a=rsa-sha256; t=1519411003; cv=none;
        d=google.com; s=arc-20160816;
        b=vlhOgooAfSnvTuk+WNv0LCqwq4NqSxW7iZAMIdJShe9puO9OQA+M4lyTkN9gKYmTOF
         hVBXa6ASXUa1YbSe7l3b1bdG8NQqcqWUS2vefVYIjB54eTlKEm1Ib2OJA/vzyS2nGCUl
         Imnxl94DLWVRlU073k7YLP2Aaiv/r+0xPKQTgiG+piWvL74QhA7xERQjkDn5RApo7A2/
         WdxUS+N5MF8A5s5tA9QbEl6F0MHrtkoyn/9JsoS5jhO7sZ4XePZcTvIW4dvrD8husl0Z
         XJlA2H2EkfijovtbtNuCntWlIAv2WiXD36l3BNlgDNj1jttzzL3LgzVAGf5meQtnCfYE
         PpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FED+d5WRitWbJEeDWcsdbJnYyW7Dj8GsvmUpwD3ohHI=;
        b=ZafpgZobPb68si4D9toWh1YTcEWhlDTNt/Q8/5eZA1YEr257CMLvrA0w0DTRaLfqUz
         jo+Qflg5ei+jdL2vwzUEr6fYq9oTvNSB3pYaAyDdldkrFdxzeNXF4c+4N7BtEw5viNT5
         6Fni+1/euYuNA73oUx+ptR+vV+E6rNGV7umrjES03Xy/YkUgkaSBp5f2kODM6xpJA1HW
         /AdL2VgGfwN1Q/XZtPJh0ChFRdIXANcihK//wAVvuDnew0RUsaESA/8KFBF/obkC7mJs
         eo2R+CDd59LVosdil0fs7t50zxqg5TakdmIu0byIOIkpINE/Fx4YEflBUDQr0Am1eL7+
         6JKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	NeilBrown <neilb@suse.com>
Subject: [PATCH 4.4 088/193] md: avoid warning for 32-bit sector_t
Date: Fri, 23 Feb 2018 19:25:21 +0100
Message-Id: <20180223170339.819523121@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217913115715178?=
X-GMAIL-MSGID: =?utf-8?q?1593217913115715178?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 3312c951efaba55080958974047414576b9e5d63 upstream.

When CONFIG_LBDAF is not set, sector_t is only 32-bits wide, which
means we cannot have devices with more than 2TB, and the code that
is trying to handle compatibility support for large devices in
md version 0.90 is meaningless but also causes a compile-time warning:

drivers/md/md.c: In function 'super_90_load':
drivers/md/md.c:1029:19: warning: large integer implicitly truncated to unsigned type [-Woverflow]
drivers/md/md.c: In function 'super_90_rdev_size_change':
drivers/md/md.c:1323:17: warning: large integer implicitly truncated to unsigned type [-Woverflow]

This adds a check for CONFIG_LBDAF to avoid even getting into this
code path, and also adds an explicit cast to let the compiler know
it doesn't have to warn about the truncation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/md.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1028,8 +1028,9 @@ static int super_90_load(struct md_rdev
 	 * (not needed for Linear and RAID0 as metadata doesn't
 	 * record this size)
 	 */
-	if (rdev->sectors >= (2ULL << 32) && sb->level >= 1)
-		rdev->sectors = (2ULL << 32) - 2;
+	if (IS_ENABLED(CONFIG_LBDAF) && (u64)rdev->sectors >= (2ULL << 32) &&
+	    sb->level >= 1)
+		rdev->sectors = (sector_t)(2ULL << 32) - 2;
 
 	if (rdev->sectors < ((sector_t)sb->size) * 2 && sb->level >= 1)
 		/* "this cannot possibly happen" ... */
@@ -1322,8 +1323,9 @@ super_90_rdev_size_change(struct md_rdev
 	/* Limit to 4TB as metadata cannot record more than that.
 	 * 4TB == 2^32 KB, or 2*2^32 sectors.
 	 */
-	if (num_sectors >= (2ULL << 32) && rdev->mddev->level >= 1)
-		num_sectors = (2ULL << 32) - 2;
+	if (IS_ENABLED(CONFIG_LBDAF) && (u64)num_sectors >= (2ULL << 32) &&
+	    rdev->mddev->level >= 1)
+		num_sectors = (sector_t)(2ULL << 32) - 2;
 	md_super_write(rdev->mddev, rdev, rdev->sb_start, rdev->sb_size,
 		       rdev->sb_page);
 	md_super_wait(rdev->mddev);
