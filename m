Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+kSvztzvmcBuRm9izrVzSnCO22GRXGhALoDbR0+IwfVDJlpENZD5aUo5YwpjMB6gi5vj2f
ARC-Seal: i=1; a=rsa-sha256; t=1523473047; cv=none;
        d=google.com; s=arc-20160816;
        b=v8pjlUve3nPr4/3kPKOFC+9jEN4vd6MPWvp1Ty9ze3NfcVHGUe7uh1pQxicM+LY2C3
         dXJlaiQOP5CiMNyFKh6xVd9PVZ2ZAO1YjnzzyryD2gTib07dlOhIoG40Nh1a2eobqpX3
         qQB1C+YsDSyh4cylFqtYt4WgcRTBx/AvlJdjX5uR9UoaJCHm8MBOn5PVsY6SRIDsMR4k
         rwD4GGy+i1QTOqtt9qKsQRPUapUR4Sg/jHknTNPQ76xBGcRg6gyAeivYkMdcVcakZ06h
         3ZjCj4fZm5dLy65E2bjpFPn/WF9hXlthzIiQfTteJ/mCP0KzuD6ZqSbC0SchwDC1Op/A
         ZGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=W1Sp1ODPve393P2KshySDTeKJBY+YwaR37oh2QjNMD4=;
        b=NZ0etSj5NQi8nf0Uvu0xwEiTp+6w4wNuE6Nxs36sGC5GXxDAEnXj4ltg8IRjFglUHF
         eHJbXa3fyCLk0n0l0kBfPeQobXP/q5RAUZ9hFT27qCMybc/Qr9xCQl9PXnGWUOYgbkxy
         PKlYx+6R8Xx13MIt9Bu+ympowXcii8uA8+f5WNxIzOBl1gXwUDKadXm80g1BYjZ93A2z
         pVGxqtWtXmrhvfDKCpXWEHiDM/gavPWzuu5ngiUgUJwJgdYF6yFm5eOS4tcYBHTZjVeb
         5P+ZGVd9J4zJzW3q8tX21kt9yWIMWsOZ4mydhvIqRUQqeo4fVN3OClHTbwgVz2G1x5M8
         nUeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	KT Liao <kt.liao@emc.com.tw>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 111/310] Input: elan_i2c - clear INT before resetting controller
Date: Wed, 11 Apr 2018 20:34:10 +0200
Message-Id: <20180411183626.969539634@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476602705887092?=
X-GMAIL-MSGID: =?utf-8?q?1597477273977888066?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KT Liao <kt.liao@emc.com.tw>


[ Upstream commit 4b3c7dbbfff0673e8a89575414b864d8b001d3bb ]

Some old touchpad FWs need to have interrupt cleared before issuing reset
command after updating firmware. We clear interrupt by attempting to read
full report from the controller, and discarding any data read.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/elan_i2c_i2c.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/input/mouse/elan_i2c_i2c.c
+++ b/drivers/input/mouse/elan_i2c_i2c.c
@@ -557,7 +557,14 @@ static int elan_i2c_finish_fw_update(str
 	long ret;
 	int error;
 	int len;
-	u8 buffer[ETP_I2C_INF_LENGTH];
+	u8 buffer[ETP_I2C_REPORT_LEN];
+
+	len = i2c_master_recv(client, buffer, ETP_I2C_REPORT_LEN);
+	if (len != ETP_I2C_REPORT_LEN) {
+		error = len < 0 ? len : -EIO;
+		dev_warn(dev, "failed to read I2C data after FW WDT reset: %d (%d)\n",
+			error, len);
+	}
 
 	reinit_completion(completion);
 	enable_irq(client->irq);
