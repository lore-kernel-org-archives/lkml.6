Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48QHJqKeTJ81x+znfK81ZACb0yKqp40nPpuRq/WnuLlz/3ASzHOlEIN2XYic6miEIfvBrq6
ARC-Seal: i=1; a=rsa-sha256; t=1524652940; cv=none;
        d=google.com; s=arc-20160816;
        b=doWpNYIZcl8Kv1ajwwGUFSqwR28teR81TnhWFSm/TzZG6VZ12v09TiMZBGKkNudg+e
         vC97fAG5V97zfaTmTQG2TzHndcJrwePoRKkS3EG9eHvUv5RB6VkSS2b/1sX9HMVZ+TcW
         COl6Hf+DbTGFW3Q0tBLpv1D/xS6ZBW/jxktvNvMWz1dYzNBn4mJ8I9vkY03nWh1jf439
         BO+VjV4pwksX3edREbJV/GPSKt90V4I4mmqDZFundxyVnjomWZXQWYEndkQlkFKTc0o0
         A+2kQEewzYsQpYno4TByNsmITL6Vjc17n0Y+7lOWvFjbEBMpFqt+gKg6bSeUdQHcN+ax
         v5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TlnIjOjeP8ReE+v4pI/5wM/OHcqTCKWGDWoqXyetSWQ=;
        b=sq9fph6gZwBtjPCblH6EcJVueZ4kxrXmo0icSexCrnovxwzwm5FEYq2u8Mk3/dfoPM
         MIrRBYs3N6VIUNN461xvDWi8osu0pUBDdYRaYzSAXdFzw+9Dx96m+VJ7k3nboiNWdKAm
         w4BT77uljzjHolWDv5KIYbW9dI116gfyI1FCXX67ymZHn2RpM9fM+iUYPmWUdeJnD84R
         JdJn87kxCSuEpYtF8ilPBqxprer94TP7Npjhs1DB+owhWgal2lPgQjUxRN5luPZ6C1NX
         KsoBtqgoCgL85krhmtyKuTK/3FBUS4+myfsMmlMjowLYbTmY8Kdf/5j8lX/vIn5dSi8l
         YUtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 125/183] s390/eadm: fix CONFIG_BLOCK include dependency
Date: Wed, 25 Apr 2018 12:35:45 +0200
Message-Id: <20180425103247.453192783@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714481697492460?=
X-GMAIL-MSGID: =?utf-8?q?1598714481697492460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Ott <sebott@linux.vnet.ibm.com>


[ Upstream commit 366b77ae43c5a3bf1a367f15ec8bc16e05035f14 ]

Commit 2a842acab109 ("block: introduce new block status code type")
added blk_status_t usage to the eadm subchannel driver. However
blk_status_t is unknown when included via <linux/blkdev.h> for CONFIG_BLOCK=n.

Only include <linux/blk_types.h> since this is the only dependency eadm has.

This fixes build failures like below:
In file included from drivers/s390/cio/eadm_sch.c:24:0:
./arch/s390/include/asm/eadm.h:111:4: error: unknown type name 'blk_status_t'; did you mean 'si_status'?
    blk_status_t error);

Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/eadm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/include/asm/eadm.h
+++ b/arch/s390/include/asm/eadm.h
@@ -4,7 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/device.h>
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
 
 struct arqb {
 	u64 data;
