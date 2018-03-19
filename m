Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELujoC3oQRNCgfs3o7ii6017YCHUCJSD5MiWRyu7rMHvkN/+osPFORSOmHmTurZffqYujmA5
ARC-Seal: i=1; a=rsa-sha256; t=1521483314; cv=none;
        d=google.com; s=arc-20160816;
        b=FJreYBM9k3C+ZAefUIAtAPJyckXXI79eX1ncOgHlednUXr6HHV02wIefVsL7weULi0
         YVIJUnZzYq7x51I+/cOq1afE+fwwgdzKfym1KEcrCpd9PEV3Uw9nw9FK8TSajH+qYcJ6
         jw1Hd4OxjWDcMEEkbPKp7Jsz9Qv8G9YkB9c0d7PmIPG08qNUQMtceyay80xKRhE7nj9L
         cOXeHKWMaooDeZJo7a8F7p5/MUHKo26zqJjxIqtLH3cKu0KAHrMj5AUMWXOsdsxdqXjB
         OUV5wt1S3DZG8IXZB+aQnUc3c+TNWTDxW2/Tk1o30oxZXumMQKCIHJc2CWmpLV3luX7f
         uwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ioo1qlFqY9DsxIXP7lkgvF0HtXFT05w3ytj86UAwILA=;
        b=mskk5FVw+r560QhLAYP6SRW+AbSDlWXCqZ6JU8yLqWp7BhSt/fOanKagUtVEIw3XYW
         zEZO1u+SizvjzsDAz2/tFMuV7vEWJOTHKp+2hxCbza9Y5aCVKvuRqKDznmDDG9MrmcQC
         xiw91/Oa2zuh6g1GWdbFQsMqYBRd58TpRRrJ8RMAeNd4RWrhymLBEFV/El83wijIkcnB
         jS6H+annuTv0UqW80MH6+Qe4LQNmeRrikHLvwn25s6shrlWq2lZWOGMZ/p6Hetm/8/Pl
         +0ZR1XFXlhP5B7HQLxCbBd4ClTQCU7lzmJhNJ4ZUrGo7u1uYKtEzKzbRX6tNviQFu8IK
         xMlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shikhar Dogra <shidogra@cisco.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 035/134] driver: (adm1275) set the m,b and R coefficients correctly for power
Date: Mon, 19 Mar 2018 19:05:18 +0100
Message-Id: <20180319171854.377436734@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390888092685404?=
X-GMAIL-MSGID: =?utf-8?q?1595390888092685404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shikhar Dogra <shidogra@cisco.com>


[ Upstream commit 6faecba0b3da7b617bf72bef422bf0d3bb6dfe7d ]

Seems like coefficient values for m, b and R under power have been
put in the wrong order. Rearranging them properly to get correct
values of coefficients for power.

For specs, please refer to table 7 (page 35) on
http://www.analog.com/media/en/technical-documentation/data-sheets/ADM1075.pdf

Fixes: 904b296f308d ("hwmon: (adm1275) Introduce configuration data structure for coeffcients")
Signed-off-by: Shikhar Dogra <shidogra@cisco.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1275.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -95,8 +95,8 @@ static const struct coefficients adm1075
 	[0] = { 27169, 0, -1 },		/* voltage */
 	[1] = { 806, 20475, -1 },	/* current, irange25 */
 	[2] = { 404, 20475, -1 },	/* current, irange50 */
-	[3] = { 0, -1, 8549 },		/* power, irange25 */
-	[4] = { 0, -1, 4279 },		/* power, irange50 */
+	[3] = { 8549, 0, -1 },		/* power, irange25 */
+	[4] = { 4279, 0, -1 },		/* power, irange50 */
 };
 
 static const struct coefficients adm1275_coefficients[] = {
