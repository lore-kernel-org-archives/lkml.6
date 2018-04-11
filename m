Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48sAhp+y83MtIN4eO+9jaqmxgX0pXVnDd9EwpRdeLtpctgSUT8BxLlSZ71902c0qXaj2lZr
ARC-Seal: i=1; a=rsa-sha256; t=1523472608; cv=none;
        d=google.com; s=arc-20160816;
        b=tnNBZbhlDGgPgXQCh3wEsEgOawyDIH5GXyKkiT9NYPC4xoS2sS+ACOiieWkJQHgu5Z
         MUtWGn3fqKKLytcy6/Bntq+GVD/GiFtwpNd6HeZuFGW45cFuOF3TEjQujrR3UyHjBopv
         LxdLVS60H2Srqy06e1IYECt9zdGjilmzmoPqaBzBINpBDlj/ftnbLBpMVCIvsFfaS2Xf
         2dzGva2SuiduLvQ+taLFhkDpIAGiG9JNocCu6Zf+wEU/M7RI2bCfZsYeBpUZqawsDgmh
         E7PlJ7qBfgCElWAbmiFgquQHjVLTaOQceXPHJ0hE8+LpehGwaOiFJLEoXvosUlv89NhP
         hdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iG4GM5kbKXG5esM7X/AegQHRUU+CArQpBxHWURQWOV4=;
        b=zHzQYtbOqjuesDCMiW7IHAHpZo3QigGYcJc1z30H+baUJ4FWHC54BBUxgoMwa+2Aj5
         RNZb9IM/wzzt0IIN88ndOG572JN+MXkPdaN1XM5B/aqrdsB5FakhacJ1cRAoB/K1NGBO
         6gzAhNcCiqZt5d4YMC0Gfe5wXSq79Pm0HwTgwW8pDvuVVdQ9QpQIYUMPV7k5tJ+SkGvl
         YVA1UjXuGFqNlAUspG7qilmfnRsUJ7XeFniQ/IiRps8vsmrBztQEVrVzFcpELIB+/Du8
         CS40Vru+MitAOT8+mlPB/fIhykbNXKDJnj1CbbpOsiSQbv4UEXo1umyTxVfP0bu4soQx
         xtxg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 147/190] s390/dasd: fix hanging safe offline
Date: Wed, 11 Apr 2018 20:36:33 +0200
Message-Id: <20180411183601.225028865@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476813509092132?=
X-GMAIL-MSGID: =?utf-8?q?1597476813509092132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Haberland <sth@linux.vnet.ibm.com>


[ Upstream commit e8ac01555d9e464249e8bb122337d6d6e5589ccc ]

The safe offline processing may hang forever because it waits for I/O
which can not be started because of the offline flag that prevents new
I/O from being started.

Allow I/O to be started during safe offline processing because in this
special case we take care that the queues are empty before throwing away
the device.

Signed-off-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1881,8 +1881,12 @@ static int __dasd_device_is_unusable(str
 {
 	int mask = ~(DASD_STOPPED_DC_WAIT | DASD_UNRESUMED_PM);
 
-	if (test_bit(DASD_FLAG_OFFLINE, &device->flags)) {
-		/* dasd is being set offline. */
+	if (test_bit(DASD_FLAG_OFFLINE, &device->flags) &&
+	    !test_bit(DASD_FLAG_SAFE_OFFLINE_RUNNING, &device->flags)) {
+		/*
+		 * dasd is being set offline
+		 * but it is no safe offline where we have to allow I/O
+		 */
 		return 1;
 	}
 	if (device->stopped) {
