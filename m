Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1D1C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AE52098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jrBFtxDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77AE52098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJQDbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:31:49 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34106 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQDbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:31:48 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9GJdhRs103718;
        Tue, 16 Oct 2018 14:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539718783;
        bh=iaLNxPcnegI3fHCjWdzC+pttaJuJtf8HBDS/Y8hWe/o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jrBFtxDZaI9I0rhVg9nTeu34deeBdvGroYHW0IvyXn2cW2OQMaw6otNIFY10sV0Ac
         HaSwv6ndLc6ccpxFq0VvQZdQZAR9lWTmb1PmswHcOwRLCrFFoHSG8oXRI6G7A1FJcV
         jXMw4cdGdZproVh3/wuooARvA0KDxKEz+6b5Fvp8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9GJdhT6032380;
        Tue, 16 Oct 2018 14:39:43 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 16
 Oct 2018 14:39:43 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 16 Oct 2018 14:39:43 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9GJdhQj031492;
        Tue, 16 Oct 2018 14:39:43 -0500
Subject: Re: [RFC PATCH net-next 2/4] net: 8021q: vlan_core: allow use list of
 vlans for real device
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, <davem@davemloft.net>
CC:     <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alexander.h.duyck@intel.com>
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
 <20181016182035.18234-3-ivan.khoronzhuk@linaro.org>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <2242102f-bfc8-e334-e9ae-93edd26587eb@ti.com>
Date:   Tue, 16 Oct 2018 14:39:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016182035.18234-3-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2018 01:20 PM, Ivan Khoronzhuk wrote:
> It's redundancy for the drivers to hold the list of vlans when
> absolutely the same list exists in vlan core. In most cases it's
> needed only to traverse the vlan devices, their vids and sync some
> settings with h/w, so add API to simplify this.
> 

below has to be under ---.

> At least some of these drivers also can benefit:
> grep "for_each.*vid" -r drivers/net/ethernet/
> 
> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:
> drivers/net/ethernet/synopsys/dwc-xlgmac-hw.c:
> drivers/net/ethernet/qlogic/qlge/qlge_main.c:
> drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c:
> drivers/net/ethernet/via/via-rhine.c:
> drivers/net/ethernet/via/via-velocity.c:
> drivers/net/ethernet/intel/igb/igb_main.c:
> drivers/net/ethernet/intel/ice/ice_main.c:
> drivers/net/ethernet/intel/e1000/e1000_main.c:
> drivers/net/ethernet/intel/i40e/i40e_main.c:
> drivers/net/ethernet/intel/e1000e/netdev.c:
> drivers/net/ethernet/intel/igbvf/netdev.c:
> drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:
> drivers/net/ethernet/intel/ixgb/ixgb_main.c:
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:
> drivers/net/ethernet/amd/xgbe/xgbe-dev.c:
> drivers/net/ethernet/emulex/benet/be_main.c:
> drivers/net/ethernet/neterion/vxge/vxge-main.c:
> drivers/net/ethernet/adaptec/starfire.c:
> drivers/net/ethernet/brocade/bna/bnad.c:
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
>   include/linux/if_vlan.h | 10 ++++++++++
>   net/8021q/vlan_core.c   | 27 +++++++++++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
> index 83ea4df6ab81..4ae3993f7166 100644
> --- a/include/linux/if_vlan.h
> +++ b/include/linux/if_vlan.h
> @@ -133,6 +133,9 @@ struct vlan_pcpu_stats {
>   
>   extern struct net_device *__vlan_find_dev_deep_rcu(struct net_device *real_dev,
>   					       __be16 vlan_proto, u16 vlan_id);
> +extern int vlan_for_each(struct net_device *dev,
> +			 int (*action)(struct net_device *dev, int vid,
> +				       void *arg), void *arg);
>   extern struct net_device *vlan_dev_real_dev(const struct net_device *dev);
>   extern u16 vlan_dev_vlan_id(const struct net_device *dev);
>   extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
> @@ -236,6 +239,13 @@ __vlan_find_dev_deep_rcu(struct net_device *real_dev,
>   	return NULL;
>   }
>   
> +static inline int
> +vlan_for_each(struct net_device *dev,
> +	      int (*action)(struct net_device *dev, int vid, void *arg),
> +	      void *arg)
> +{
> +}
> +
>   static inline struct net_device *vlan_dev_real_dev(const struct net_device *dev)
>   {
>   	BUG();
> diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
> index 4f60e86f4b8d..6308b5427a66 100644
> --- a/net/8021q/vlan_core.c
> +++ b/net/8021q/vlan_core.c
> @@ -223,6 +223,33 @@ static int vlan_kill_rx_filter_info(struct net_device *dev, __be16 proto, u16 vi
>   		return -ENODEV;
>   }
>   
> +int vlan_for_each(struct net_device *dev,
> +		  int (*action)(struct net_device *dev, int vid, void *arg),
> +		  void *arg)
> +{
> +	struct vlan_vid_info *vid_info;
> +	struct vlan_info *vlan_info;
> +	struct net_device *vdev;
> +	int ret;
> +
> +	ASSERT_RTNL();
> +
> +	vlan_info = rtnl_dereference(dev->vlan_info);
> +	if (!vlan_info)
> +		return 0;
> +
> +	list_for_each_entry(vid_info, &vlan_info->vid_list, list) {
> +		vdev = vlan_group_get_device(&vlan_info->grp, vid_info->proto,
> +					     vid_info->vid);
> +		ret = action(vdev, vid_info->vid, arg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(vlan_for_each);
> +
>   int vlan_filter_push_vids(struct vlan_info *vlan_info, __be16 proto)
>   {
>   	struct net_device *real_dev = vlan_info->real_dev;
> 

-- 
regards,
-grygorii
