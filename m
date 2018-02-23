Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226A6jH2bBPRey26FwQoKTi/cTHAPo2ozuo51/1WbXva/C5al5jnZ6VLFclwYIfiK6xTLFta
ARC-Seal: i=1; a=rsa-sha256; t=1519411191; cv=none;
        d=google.com; s=arc-20160816;
        b=L4gjeEhU7r67nCoAJHrbkepW8kzboG/6j561VIp/anAf9sSpzAAOpeTm0AbzDrTMI1
         dUrZvOTcwTwjXHQ1a/b1KpqnFLijsi8UDlxh0WINF4gcRMdEFuwYJVGOGsNUhmETm/VG
         83FnIEzRMzRcS7ElzzVwX9Nh73gq0RhukwHmUz1xORALqg8hf5ZLLd36GwI7+FR/ebJ6
         vPvm1m5Z7Cb4uFpoyx35u0PKLqMt8riaD6hX41kPCAPpmPEvGptkNPdXxbyD0t1VM9cb
         r0J1MKAWHx6kED6bszc9OvhxXP7uQ81jnK6/AbOgoRyfr30EBp8UlCx2nl1P0/H0zalb
         84rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ru0rIDU/dLq4ulzLQZ80LKlSpHrSRNs6g9SiqYtw7ic=;
        b=SY1tnI3n04FknVX2UmHRJpimMt8mry4oB8NfUYSU2R8trKXn9DtniB0c5MAq2Ez3+h
         ToAE9tGZyWMVrAtjvGUY/hM5YyTqqkkemC8/y9NbDBzNzabLCsTpMOMNg/S3ksZParBS
         rG0i7rXOXbBPQvxDnKSPUHqWm5tCMQX54KcrKvqzGv8AmsrT4JFekDb7zvIhpD0m+VXv
         NIf22qf4XqhR03xguZf9B+WvS5iyFfr6Ef38GXa5woqf3aiV5M14j+8LogE6OJruFg0S
         K/XRbM7MeWYpcDKgJdplp/V/ZtEpY4LW5Da6B23PK4IDp7xjtzyxR37WmNcMmZRTS3l8
         +aZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 151/193] isdn: sc: work around type mismatch warning
Date: Fri, 23 Feb 2018 19:26:24 +0100
Message-Id: <20180223170349.616543647@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218109801119517?=
X-GMAIL-MSGID: =?utf-8?q?1593218109801119517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

This driver shows warnings on many architectures:

drivers/isdn/sc/init.c: In function 'identify_board':
drivers/isdn/sc/init.c:484:2: error: passing argument 1 of 'readl' makes pointer from integer without a cast [-Werror]

In newer kernels, it was completely removed, but for the 4.4-stable
series, let's just shut up that warning by adding an extra variable
to do the necessary type cast.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/isdn/sc/init.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/isdn/sc/init.c
+++ b/drivers/isdn/sc/init.c
@@ -441,6 +441,7 @@ static int identify_board(unsigned long
 	RspMessage rcvmsg;
 	ReqMessage sndmsg;
 	HWConfig_pl hwci;
+	void __iomem *rambase_sig = (void __iomem *)rambase + SIG_OFFSET;
 	int x;
 
 	pr_debug("Attempting to identify adapter @ 0x%lx io 0x%x\n",
@@ -481,7 +482,7 @@ static int identify_board(unsigned long
 	 */
 	outb(PRI_BASEPG_VAL, pgport);
 	msleep_interruptible(1000);
-	sig = readl(rambase + SIG_OFFSET);
+	sig = readl(rambase_sig);
 	pr_debug("Looking for a signature, got 0x%lx\n", sig);
 	if (sig == SIGNATURE)
 		return PRI_BOARD;
@@ -491,7 +492,7 @@ static int identify_board(unsigned long
 	 */
 	outb(BRI_BASEPG_VAL, pgport);
 	msleep_interruptible(1000);
-	sig = readl(rambase + SIG_OFFSET);
+	sig = readl(rambase_sig);
 	pr_debug("Looking for a signature, got 0x%lx\n", sig);
 	if (sig == SIGNATURE)
 		return BRI_BOARD;
@@ -501,7 +502,7 @@ static int identify_board(unsigned long
 	/*
 	 * Try to spot a card
 	 */
-	sig = readl(rambase + SIG_OFFSET);
+	sig = readl(rambase_sig);
 	pr_debug("Looking for a signature, got 0x%lx\n", sig);
 	if (sig != SIGNATURE)
 		return -1;
