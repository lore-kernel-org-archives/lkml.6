Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/uxTAjrJ1tAVE/7ry1wvGuylNf6FPiEkh9pvUP1/ho57jZdiQ18rB4sSwiMDOI4tCjd5E/
ARC-Seal: i=1; a=rsa-sha256; t=1524652826; cv=none;
        d=google.com; s=arc-20160816;
        b=VbQJP13UOBXIjYzTTVFTYbsAbesa5dQSOGBsL1oDeT430es2Pmxie4sCuHPMGe+k9L
         3FpaxRlpeKiBJApz1354729+HQl23Rdv1Vq25K+1OcwZ+ulGwZznExhVgQxwYDaH+06q
         3Tjek5+epbfEvc+f862lrlSaewmTs14FVwPMPipb+p+InO7XJSj6tkEfmtt3VawfW28S
         0ZP4cRC5o4wcrxp0BMe4Vc4N7YN8ADhWi4lt3m3yQk7vmsj7J2WpA+GON8EWWFqZ9hQ1
         50kp17mO0Y4Pg4WtFqq06ReeqyYym2SuRzLctUVS6dpNv2I/T75Plzgg8HwXVswWVI1T
         zplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tZO3RfP/SFhikrKY39AGDE5h2vGDjHuEndyVmVIUpOc=;
        b=eVSkuTAFUA5uRl5Jt4gCbnqNlWxXRnnPRtCxCUMI4YuhdFThhOtIoO4qxna2ha5A44
         QEpFN0H3Qb4utNb+cyyvWe6lx0HdqfiyR2KYyIcvHOCgNMRXg2YjGnH9CLeMMi4j/xxx
         fWrCv3T2vRhpaKWRIhYdp87smFQlSZMeLS4XZmyaNHkAIlO4do1Gj9ZcWsqREIaD4M1G
         aHFzPLPI9TzmVCqq4Rfz+pf1CjHO/MokTFb17H+IAad2Yz3ocaFCwWK6Bj6zogmdGRgc
         DoOz/gLZGCgFHcW2oGIn3KBsvuWK72prtowwTh+6aOFXIMrVDuQFB0x5+AUdFDVNEgU0
         EovA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Corinna Vinschen <vinschen@redhat.com>,
	Aaron Brown <arron.f.brown@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 084/183] igb: Allow to remove administratively set MAC on VFs
Date: Wed, 25 Apr 2018 12:35:04 +0200
Message-Id: <20180425103245.877600678@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714362796374471?=
X-GMAIL-MSGID: =?utf-8?q?1598714362796374471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corinna Vinschen <vinschen@redhat.com>


[ Upstream commit 177132df5e45b134c147f419f567a3b56aafaf2b ]

Before libvirt modifies the MAC address and vlan tag for an SRIOV VF
for use by a virtual machine (either using vfio device assignment or
macvtap passthru mode), it saves the current MAC address and vlan tag
so that it can reset them to their original value when the guest is
done.  Libvirt can't leave the VF MAC set to the value used by the
now-defunct guest since it may be started again later using a
different VF, but it certainly shouldn't just pick any random value,
either. So it saves the state of everything prior to using the VF, and
resets it to that.

The igb driver initializes the MAC addresses of all VFs to
00:00:00:00:00:00, and reports that when asked (via an RTM_GETLINK
netlink message, also visible in the list of VFs in the output of "ip
link show"). But when libvirt attempts to restore the MAC address back
to 00:00:00:00:00:00 (using an RTM_SETLINK netlink message) the kernel
responds with "Invalid argument".

Forbidding a reset back to the original value leaves the VF MAC at the
value set for the now-defunct virtual machine. Especially on a system
with NetworkManager enabled, this has very bad consequences, since
NetworkManager forces all interfacess to be IFF_UP all the time - if
the same virtual machine is restarted using a different VF (or even on
a different host), there will be multiple interfaces watching for
traffic with the same MAC address.

To allow libvirt to revert to the original state, we need a way to
remove the administrative set MAC on a VF, to allow normal host
operation again, and to reset/overwrite the VF MAC via VF netdev.

This patch implements the outlined scenario by allowing to set the
VF MAC to 00:00:00:00:00:00 via RTM_SETLINK on the PF.
igb_ndo_set_vf_mac resets the IGB_VF_FLAG_PF_SET_MAC flag to 0,
so it's possible to reset the VF MAC back to the original value via
the VF netdev.

Note: Recent patches to libvirt allow for a workaround if the NIC
isn't capable of resetting the administrative MAC back to all 0, but
in theory the NIC should allow resetting the MAC in the first place.

Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
Tested-by: Aaron Brown <arron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c |   42 ++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 11 deletions(-)

--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8373,7 +8373,8 @@ static void igb_rar_set_index(struct igb
 
 	/* Indicate to hardware the Address is Valid. */
 	if (adapter->mac_table[index].state & IGB_MAC_STATE_IN_USE) {
-		rar_high |= E1000_RAH_AV;
+		if (is_valid_ether_addr(addr))
+			rar_high |= E1000_RAH_AV;
 
 		if (hw->mac.type == e1000_82575)
 			rar_high |= E1000_RAH_POOL_1 *
@@ -8411,17 +8412,36 @@ static int igb_set_vf_mac(struct igb_ada
 static int igb_ndo_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
-	if (!is_valid_ether_addr(mac) || (vf >= adapter->vfs_allocated_count))
+
+	if (vf >= adapter->vfs_allocated_count)
+		return -EINVAL;
+
+	/* Setting the VF MAC to 0 reverts the IGB_VF_FLAG_PF_SET_MAC
+	 * flag and allows to overwrite the MAC via VF netdev.  This
+	 * is necessary to allow libvirt a way to restore the original
+	 * MAC after unbinding vfio-pci and reloading igbvf after shutting
+	 * down a VM.
+	 */
+	if (is_zero_ether_addr(mac)) {
+		adapter->vf_data[vf].flags &= ~IGB_VF_FLAG_PF_SET_MAC;
+		dev_info(&adapter->pdev->dev,
+			 "remove administratively set MAC on VF %d\n",
+			 vf);
+	} else if (is_valid_ether_addr(mac)) {
+		adapter->vf_data[vf].flags |= IGB_VF_FLAG_PF_SET_MAC;
+		dev_info(&adapter->pdev->dev, "setting MAC %pM on VF %d\n",
+			 mac, vf);
+		dev_info(&adapter->pdev->dev,
+			 "Reload the VF driver to make this change effective.");
+		/* Generate additional warning if PF is down */
+		if (test_bit(__IGB_DOWN, &adapter->state)) {
+			dev_warn(&adapter->pdev->dev,
+				 "The VF MAC address has been set, but the PF device is not up.\n");
+			dev_warn(&adapter->pdev->dev,
+				 "Bring the PF device up before attempting to use the VF device.\n");
+		}
+	} else {
 		return -EINVAL;
-	adapter->vf_data[vf].flags |= IGB_VF_FLAG_PF_SET_MAC;
-	dev_info(&adapter->pdev->dev, "setting MAC %pM on VF %d\n", mac, vf);
-	dev_info(&adapter->pdev->dev,
-		 "Reload the VF driver to make this change effective.");
-	if (test_bit(__IGB_DOWN, &adapter->state)) {
-		dev_warn(&adapter->pdev->dev,
-			 "The VF MAC address has been set, but the PF device is not up.\n");
-		dev_warn(&adapter->pdev->dev,
-			 "Bring the PF device up before attempting to use the VF device.\n");
 	}
 	return igb_set_vf_mac(adapter, vf, mac);
 }
