Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtVMCW/Wd7uyk2UHvhmmXkIoOfcYySBCSKjNDesAA50rc+c1gj5rjY22fPIIjbAxeF+vkIi
ARC-Seal: i=1; a=rsa-sha256; t=1521482996; cv=none;
        d=google.com; s=arc-20160816;
        b=Ohg3e8awToNVG9Sw3E0mYbhGJ/2gs2WnVnC0hSWgCF6dMFxk6SGVNX3Du1WxxVUXCh
         9onwXU/aphYPO7Kn3cKVt3HsEDGboY6V+/LzFPJGfpdkVhb0YQWFSf8Q3Ufxk9VnSczz
         hJvLuuUEf9+pr2QmgyyuwNptcLi7TLMMy2HxQyXKiExt6hHkQaLBWrIKnk3l+wXw+q3L
         9SfBx9gfRY0IHQgkPbR8tldGSlxHnA4ItEWMNrkwnn6Eue/Aq6tc8oloRPdYrSsJpKwK
         116FGcIIDFZpmbJR7PeFVh3RELDZxNm70Eh6mUJmdyDCiGMnyXo8DKrR/0Qf8a7BSN4r
         +NAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YMzTBeC87DutcKkMWXkv4yRPGlXlBYsnYwBu74AWSDU=;
        b=KgZ9wlhBBdztjgDYQ08B7gPbLe4kUT4dBsenLZpELTz+9HJVTQ6QWgRsPYd6TQhEQb
         DcjtKQVgv35ZHPgMOBfHD3dbV+XT5kSKyR13y/uHjGL+U/TE4FpJfyCndmzPbs6hzEnY
         Vc7ZRNVlyj1wo7JEvaaLWceWbZkqy7VOFOQp4xi18F8kJyrXj7/XyJEA9ssIJ2A/P0gv
         1A/cvJFtkFUCGF/vtZQaxi2dQXuhxyK+HBIotBsUzQMXPFrWFS2KijPf0BH7yQZYh7Et
         wOUjuqFmzBDXcYImkdUCd/tuTBX828YYdrgdKhg0hC/PSQDjWfJhKNSHmCKOcYApUwTZ
         sa8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Phil Turnbull <phil.turnbull@oracle.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 29/68] fm10k: correctly check if interface is removed
Date: Mon, 19 Mar 2018 19:06:07 +0100
Message-Id: <20180319171831.869535028@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390554893917373?=
X-GMAIL-MSGID: =?utf-8?q?1595390554893917373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Turnbull <phil.turnbull@oracle.com>


[ Upstream commit 540fca35e38d15777b310f450f63f056e63039f5 ]

FM10K_REMOVED expects a hardware address, not a 'struct fm10k_hw'.

Fixes: 5cb8db4a4cbc ("fm10k: Add support for VF")
Signed-off-by: Phil Turnbull <phil.turnbull@oracle.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -840,7 +840,7 @@ static void fm10k_self_test(struct net_d
 
 	memset(data, 0, sizeof(*data) * FM10K_TEST_LEN);
 
-	if (FM10K_REMOVED(hw)) {
+	if (FM10K_REMOVED(hw->hw_addr)) {
 		netif_err(interface, drv, dev,
 			  "Interface removed - test blocked\n");
 		eth_test->flags |= ETH_TEST_FL_FAILED;
