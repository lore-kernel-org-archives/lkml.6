Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELuDrtj/poXhgkE05Ypa18dxGTBGzsyOmLc9xlgxbWDtqALlPy54+SwGJTbS9EnDAAjh73NK
ARC-Seal: i=1; a=rsa-sha256; t=1520334264; cv=none;
        d=google.com; s=arc-20160816;
        b=vzaHhYuDkKZsHEZlJFKLq+bjSUZIfFNRSjLdJIlKaqgMPE1Rp5J3YtaNx/F7p9a7ad
         UCeDccLY5fzU/i2Q0bJEhxKOA107CKPA6a6lwyv5lBKPBaAU/Zp5hWSPo5+QggWo8+8i
         xuwQpe98Pm17M4Lcxo4oygKhiXqUdakpeIjIZrvsfZ+nEfJ2mGow4+z2HClxEfj0uCeG
         V9kIPurT+HA4/JlBBESpfs8JIpTa5U6NlXxVXn4D2MFqDpDOaGNPBXlfVEP4RTDitvFl
         qgK9IKB2+0l3T7g9rd8k26pz/gmMJFmY5GM0on4WRklpxmJiRJ88D8CFe0WEGGWxgcWk
         L2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=hEhY7n8iduYHu3quSCGXXo87gyfMRQrJ4IQ65g67uFo=;
        b=zBjd8DkvCkDSukxtblVTGOPFI4F1WU1fsJ1hiuieBMT0pao8apVGo/30cMXwgNNzNQ
         rz0XJoxUtly2j1W2Xb7UYZMhJaCgh7znUJFbx14sn/zyvzQ6PzFUhAMIwIbWcrjFvNMt
         H6ZY0jjEeU2fegcaKJjjT97+y2bnnV/h3d0xmUE4Lg31MUax+xCh7wUuNA4pwpp6GteM
         8Utgffu0J0Epo6sQhwERADz3Vws3qsZZ/OjhrcPREgr4Z3gCKVfi9xF8iBIQWP7xcpf6
         9QrUezfTx7qP7+Ab/6/JEJ4Ez6TlpbhsJe/t00S8qenOnHzQPXiZcioOQzCpVEFdEZMl
         2yIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.15 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.15 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <f8d72625a5a709bd29e05bdae7307691>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/3] regmap: debugfs: Free map->debugfs_name when debugfs_create_dir() failed
Date: Tue,  6 Mar 2018 19:04:03 +0800
Message-Id: <20180306110403.14438-3-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180306110403.14438-1-jeffy.chen@rock-chips.com>
References: <20180306110403.14438-1-jeffy.chen@rock-chips.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594186021172605420?=
X-GMAIL-MSGID: =?utf-8?q?1594186021172605420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Free map->debugfs_name when debugfs_create_dir() failed to avoid memory
leak.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/base/regmap/regmap-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 5479a183248f..55e862a81e82 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -582,6 +582,9 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 	map->debugfs = debugfs_create_dir(name, regmap_debugfs_root);
 	if (!map->debugfs) {
 		dev_warn(map->dev, "Failed to create debugfs directory\n");
+
+		kfree(map->debugfs_name);
+		map->debugfs_name = NULL;
 		return;
 	}
 
-- 
2.11.0
