Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/EI27sFVmMRFlwWqdUHoVFT3rdKOK1/ehFTCBAIeX8Vq41M4BUrsMvpU7cgqH7KRAMbg93
ARC-Seal: i=1; a=rsa-sha256; t=1523399821; cv=none;
        d=google.com; s=arc-20160816;
        b=OM9zPeFZ/13kr36L08KAdadoR7gb/DfRl4AKBjzhyA8FiFXSFhymyUW4rj6iXBOAGw
         gPzfzWBrpTCGGQUtXy7sVvbtpX/ULVQPUMIwasAy8Poyb/5f4c/SaU9Tq/Zmiyn3yNYT
         nJbpzps77DU+5V3a4qwD3ijVVBmqZnGtawK8lKdnJEmc1s/Kc6KSYTL/yV6ZpioRdXoa
         BV6CHFsz3ls37Afnk5JMD32xDTpwFuupqJ8h/Z7GLEpuTmquFBsUjBfDNt+9ceR6AhU5
         soFSFSaUiwYPehUh8s1iqfCLi0IrdtByMWSgwU25x29It4pXXbIvrZ8Hk4gyb4hqYojh
         GNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Sg4y9PeKmgRYlPk3AGd2GgyvDQzYVtggpbswWeOfRNA=;
        b=n1DZxbAkZXBVm6WzEr78pnbGQBi1tnV+oi/Xz1R9f89/brWC3azne+piGJoFgZcEV9
         khju36nr96HCHzRgy8diiT0DoNEjcBP3OY/v23vdW7x9ZlFVKwJAbpcqRznLkagO77N8
         C6JgpJt84H8JCgf/zBZrGEIoW53WZydrUrcEW2sNUD11KwddzYCnbCeVgSr6ANmmn7Q7
         v1PimO38YsQ03R7gHWj6X7Eic8jH003WXB+jposhxdPHhspWDPJjMquqmW+A3UNWqzqF
         W/9KG7zjoyK6KSazmn99yhHoDc9Gx63cCqLj9sf2HwmiHnOjgw9nv3tcfe1NYaWdDVJM
         m1MQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Bowers <andrewx.bowers@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 068/138] i40evf: dont rely on netif_running() outside rtnl_lock()
Date: Wed, 11 Apr 2018 00:24:18 +0200
Message-Id: <20180410212910.008358359@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400039408034049?=
X-GMAIL-MSGID: =?utf-8?q?1597400490553866741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>


[ Upstream commit 44b034b406211fc103159f82b9e601e05675c739 ]

In i40evf_reset_task we use netif_running() to determine whether or not
the device is currently up. This allows us to properly free queue memory
and shut down things before we request the hardware reset.

It turns out that we cannot be guaranteed of netif_running() returning
false until the device is fully up, as the kernel core code sets
__LINK_STATE_START prior to calling .ndo_open. Since we're not holding
the rtnl_lock(), it's possible that the driver's i40evf_open handler
function is currently being called while we're resetting.

We can't simply hold the rtnl_lock() while checking netif_running() as
this could cause a deadlock with the i40evf_open() function.
Additionally, we can't avoid the deadlock by holding the rtnl_lock()
over the whole reset path, as this essentially serializes all resets,
and can cause massive delays if we have multiple VFs on a system.

Instead, lets just check our own internal state __I40EVF_RUNNING state
field. This allows us to ensure that the state is correct and is only
set after we've finished bringing the device up.

Without this change we might free data structures about device queues
and other memory before they've been fully allocated.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1775,7 +1775,11 @@ static void i40evf_disable_vf(struct i40
 
 	adapter->flags |= I40EVF_FLAG_PF_COMMS_FAILED;
 
-	if (netif_running(adapter->netdev)) {
+	/* We don't use netif_running() because it may be true prior to
+	 * ndo_open() returning, so we can't assume it means all our open
+	 * tasks have finished, since we're not holding the rtnl_lock here.
+	 */
+	if (adapter->state == __I40EVF_RUNNING) {
 		set_bit(__I40E_VSI_DOWN, adapter->vsi.state);
 		netif_carrier_off(adapter->netdev);
 		netif_tx_disable(adapter->netdev);
@@ -1833,6 +1837,7 @@ static void i40evf_reset_task(struct wor
 	struct i40evf_mac_filter *f;
 	u32 reg_val;
 	int i = 0, err;
+	bool running;
 
 	while (test_and_set_bit(__I40EVF_IN_CLIENT_TASK,
 				&adapter->crit_section))
@@ -1892,7 +1897,13 @@ static void i40evf_reset_task(struct wor
 	}
 
 continue_reset:
-	if (netif_running(netdev)) {
+	/* We don't use netif_running() because it may be true prior to
+	 * ndo_open() returning, so we can't assume it means all our open
+	 * tasks have finished, since we're not holding the rtnl_lock here.
+	 */
+	running = (adapter->state == __I40EVF_RUNNING);
+
+	if (running) {
 		netif_carrier_off(netdev);
 		netif_tx_stop_all_queues(netdev);
 		adapter->link_up = false;
@@ -1936,7 +1947,10 @@ continue_reset:
 
 	mod_timer(&adapter->watchdog_timer, jiffies + 2);
 
-	if (netif_running(adapter->netdev)) {
+	/* We were running when the reset started, so we need to restore some
+	 * state here.
+	 */
+	if (running) {
 		/* allocate transmit descriptors */
 		err = i40evf_setup_all_tx_resources(adapter);
 		if (err)
