Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuri1xS1TyBuu3JAxsEbZuSpDJtZzWRdCdupQI5mt57mhQrL945H+vVSP0/iLfYj+vVrdCV
ARC-Seal: i=1; a=rsa-sha256; t=1519981409; cv=none;
        d=google.com; s=arc-20160816;
        b=bFYCO5//JCpibANCVvW2JW21lJE1g/4mfcIyr0zmb5vITdReNfGr5mH+tE4E4rRLsw
         NgdgocbKxx5HKNJN7FZg2UhI/N++Yzr7vvq9KY1gmHw8OgYDY1Mi3fdBPb4Zw24kKMBM
         Aliow+CURyKme3JXJ53V7ITCjzyo/6SGZ0TdjoT3FTBFx13bEaLgrkPrJaLoB25/RvuI
         vHyOd+obq/B9NIjtn+PheAGjW/32iSvYfMCamDoovuuKwW/KrasYPYwLGeM8umqJHH3c
         fRor8dkq5z+taKSOxJsTGu+YCD9aMa2ViAFo+aDZPnyh3WDfPyoq6Z5r2NOAdzUo6mtt
         UATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YObUDLtSRX+JUgiDKKLdIz8++VA1wQBXnQCAyqDSE10=;
        b=ow1UzYTfMDOeOc/pbSO/vPkrC/0iyltw0J9QYt8BO5evEVgQKkBDpJCnN/HdJl5Sjm
         e53AhESOcb/JoELUBuBwCfurpS/dh5QL6ySZoUS6NzwnYRQIU3a/tVE1KtpD6JWZRE7I
         UKui8nswUCtRaNtNzIZpql/iTmqyjaE8auFcfq8pXQHtN634/AgeAd6fwHdYL2wU3cRx
         nfGvME6nnjSyWsjse+RqaTBmhXIxxj7Xb2XmLvPZAM0pwgEU5LIo2GNPPlC+z7eH1F8M
         gwspDbEf6QHuWiClZ5wKgPTirl80AeXWoV3fzOiN3vWmKznZ83sO/xoW2zyyJlVNi+Tv
         oqEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Bowers <andrewx.bowers@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 082/115] i40e: dont remove netdev->dev_addr when syncing uc list
Date: Fri,  2 Mar 2018 09:51:25 +0100
Message-Id: <20180302084507.168261150@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816026353255685?=
X-GMAIL-MSGID: =?utf-8?q?1593816026353255685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>


[ Upstream commit 458867b2ca0c987445c5d9adccd1642970e1ba07 ]

In some circumstances, such as with bridging, it is possible that the
stack will add a devices own MAC address to its unicast address list.

If, later, the stack deletes this address, then the i40e driver will
receive a request to remove this address.

The driver stores its current MAC address as part of the MAC/VLAN hash
array, since it is convenient and matches exactly how the hardware
expects to be told which traffic to receive.

This causes a problem, since for more devices, the MAC address is stored
separately, and requests to delete a unicast address should not have the
ability to remove the filter for the MAC address.

Fix this by forcing a check on every address sync to ensure we do not
remove the device address.

There is a very narrow possibility of a race between .set_mac and
.set_rx_mode, if we don't change netdev->dev_addr before updating our
internal MAC list in .set_mac. This might be possible if .set_rx_mode is
going to remove MAC "XYZ" from the list, at the same time as .set_mac
changes our dev_addr to MAC "XYZ", we might possibly queue a delete,
then an add in .set_mac, then queue a delete in .set_rx_mode's
dev_uc_sync and then update netdev->dev_addr. We can avoid this by
moving the copy into dev_addr prior to the changes to the MAC filter
list.

A similar race on the other side does not cause problems, as if we're
changing our MAC form A to B, and we race with .set_rx_mode, it could
queue a delete from A, we'd update our address, and allow the delete.
This seems like a race, but in reality we're about to queue a delete of
A anyways, so it would not cause any issues.

A race in the initialization code is unlikely because the netdevice has
not yet been fully initialized and the stack should not be adding or
removing addresses yet.

Note that we don't (yet) need similar code for the VF driver because it
does not make use of __dev_uc_sync and __dev_mc_sync, but instead roles
its own method for handling updates to the MAC/VLAN list, which already
has code to protect against removal of the hardware address.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1553,11 +1553,18 @@ static int i40e_set_mac(struct net_devic
 	else
 		netdev_info(netdev, "set new mac address %pM\n", addr->sa_data);
 
+	/* Copy the address first, so that we avoid a possible race with
+	 * .set_rx_mode(). If we copy after changing the address in the filter
+	 * list, we might open ourselves to a narrow race window where
+	 * .set_rx_mode could delete our dev_addr filter and prevent traffic
+	 * from passing.
+	 */
+	ether_addr_copy(netdev->dev_addr, addr->sa_data);
+
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 	i40e_del_mac_filter(vsi, netdev->dev_addr);
 	i40e_add_mac_filter(vsi, addr->sa_data);
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
-	ether_addr_copy(netdev->dev_addr, addr->sa_data);
 	if (vsi->type == I40E_VSI_MAIN) {
 		i40e_status ret;
 
@@ -1739,6 +1746,14 @@ static int i40e_addr_unsync(struct net_d
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 
+	/* Under some circumstances, we might receive a request to delete
+	 * our own device address from our uc list. Because we store the
+	 * device address in the VSI's MAC/VLAN filter list, we need to ignore
+	 * such requests and not delete our device address from this list.
+	 */
+	if (ether_addr_equal(addr, netdev->dev_addr))
+		return 0;
+
 	i40e_del_mac_filter(vsi, addr);
 
 	return 0;
