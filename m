Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392C9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD502098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dz0VOjRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD502098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeJQA12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:27:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51892 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJQA12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:27:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9GGTRTE148982;
        Tue, 16 Oct 2018 16:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=hIwgutW3wH9Tk/ML2VLUfmnCZUR1Mh5fdljm41t1W8I=;
 b=dz0VOjRt+DXvBvhkp9yMXhu9IIt8grdF9A1dM51qCWgy+cEKK+QWJh+suQLX3CxFTWPs
 Nkh+/uZ0Ym+lisEnq/ubaRTpLlDXVdl2lw+vquCpMax4IiyoWOyxyA8ns0kzRqki2M/a
 jVdN6odlByFQn3UQPiLK1JjAihew/mfnzdrAq8Nh5CT586bswx59N1bmnTFEQmTX7KK+
 w9KoB1IpM0J4QkyrgiIm3GqwmVHaDL4GznlZz2167Pmw3q9MGjnF0eQHy2CsvIxjmXpD
 FrexzBBARaPHfLNU62mO1e7k/HKdth+kSIEelRwuJvETrtUU8xoVXGYm/WsIVkvqq7hd 1A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2n38nq1y02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 16:35:56 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9GGZnAb030737
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 16:35:49 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9GGZlvc025490;
        Tue, 16 Oct 2018 16:35:47 GMT
Received: from [10.159.237.5] (/10.159.237.5)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Oct 2018 09:35:47 -0700
Subject: Re: [PATCH net-next] ixgbe: fix XFRM_ALGO dependency
To:     Arnd Bergmann <arnd@arndb.de>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181016100848.1329843-1-arnd@arndb.de>
From:   Shannon Nelson <shannon.nelson@oracle.com>
Organization: Oracle Corporation
Message-ID: <07e372cb-06da-bf95-bc53-64ee09fc8e76@oracle.com>
Date:   Tue, 16 Oct 2018 09:35:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016100848.1329843-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 3:03 AM, Arnd Bergmann wrote:
> When XFRM_ALGO is not enabled, the new igxge ipsec code produces a
> link error:

s/igxge/ixgbe/

> 
> drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.o: In function `ixgbe_ipsec_vf_add_sa':
> ixgbe_ipsec.c:(.text+0x1266): undefined reference to `xfrm_aead_get_byname'
> 
> Simply selectin XFRM_ALGO from here causes circular dependencies, so

s/selectin/selecting/

> to fix it, we probably want this slightly more complex solution that is
> similar to what other drivers with XFRM offload do:
> 
> A separate Kconfig symbol now controls whether we include the ipsec
> offload code. To keep the old behavior, this is left as 'default y'. The
> dependency in XFRM_OFFLOAD still causes a circular dependency but is
> not actually needed because this symbol is not user visible, so removing
> that dependency on top makes it all work.
> 
> Fixes: eda0333ac293 ("ixgbe: add VF IPsec management")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/intel/Kconfig            | 10 ++++++++++
>   drivers/net/ethernet/intel/ixgbe/Makefile     |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  8 ++++----
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  6 +++---
>   net/xfrm/Kconfig                              |  1 -
>   5 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> index b542aba6f0e8..d1db382d8299 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -194,6 +194,16 @@ config IXGBE_DCB
>   
>   	  If unsure, say N.
>   
> +config IXGBE_IPSEC
> +	bool "IPSec XFRM cryptography-offload accelaration"
> +	default n

remove this "default n" line?

> +	depends on IXGBE
> +	depends on XFRM_OFFLOAD
> +	default y
> +	select XFRM_ALGO
> +	---help---
> +	  Enable support for IPSec offload in ixgbe.ko
> +
>   config IXGBEVF
>   	tristate "Intel(R) 10GbE PCI Express Virtual Function Ethernet support"
>   	depends on PCI_MSI
> diff --git a/drivers/net/ethernet/intel/ixgbe/Makefile b/drivers/net/ethernet/intel/ixgbe/Makefile
> index ca6b0c458e4a..4fb0d9e3f2da 100644
> --- a/drivers/net/ethernet/intel/ixgbe/Makefile
> +++ b/drivers/net/ethernet/intel/ixgbe/Makefile
> @@ -17,4 +17,4 @@ ixgbe-$(CONFIG_IXGBE_DCB) +=  ixgbe_dcb.o ixgbe_dcb_82598.o \
>   ixgbe-$(CONFIG_IXGBE_HWMON) += ixgbe_sysfs.o
>   ixgbe-$(CONFIG_DEBUG_FS) += ixgbe_debugfs.o
>   ixgbe-$(CONFIG_FCOE:m=y) += ixgbe_fcoe.o
> -ixgbe-$(CONFIG_XFRM_OFFLOAD) += ixgbe_ipsec.o
> +ixgbe-$(CONFIG_IXGBE_IPSEC) += ixgbe_ipsec.o
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index 7a7679e7be84..1d5d66436eac 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -770,9 +770,9 @@ struct ixgbe_adapter {
>   #define IXGBE_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
>   	u32 *rss_key;
>   
> -#ifdef CONFIG_XFRM_OFFLOAD
> +#ifdef CONFIG_IXGBE_IPSEC
>   	struct ixgbe_ipsec *ipsec;
> -#endif /* CONFIG_XFRM_OFFLOAD */
> +#endif /* CONFIG_IXGBE_IPSEC */

You'll probably want to apply these changes to the ixgbevf code as well.

Cheers,
sln

>   
>   	/* AF_XDP zero-copy */
>   	struct xdp_umem **xsk_umems;
> @@ -1009,7 +1009,7 @@ void ixgbe_store_key(struct ixgbe_adapter *adapter);
>   void ixgbe_store_reta(struct ixgbe_adapter *adapter);
>   s32 ixgbe_negotiate_fc(struct ixgbe_hw *hw, u32 adv_reg, u32 lp_reg,
>   		       u32 adv_sym, u32 adv_asm, u32 lp_sym, u32 lp_asm);
> -#ifdef CONFIG_XFRM_OFFLOAD
> +#ifdef CONFIG_IXGBE_IPSEC
>   void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter);
>   void ixgbe_stop_ipsec_offload(struct ixgbe_adapter *adapter);
>   void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter);
> @@ -1037,5 +1037,5 @@ static inline int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter,
>   					u32 *mbuf, u32 vf) { return -EACCES; }
>   static inline int ixgbe_ipsec_vf_del_sa(struct ixgbe_adapter *adapter,
>   					u32 *mbuf, u32 vf) { return -EACCES; }
> -#endif /* CONFIG_XFRM_OFFLOAD */
> +#endif /* CONFIG_IXGBE_IPSEC */
>   #endif /* _IXGBE_H_ */
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 0049a2becd7e..113b38e0defb 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -8694,7 +8694,7 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
>   
>   #endif /* IXGBE_FCOE */
>   
> -#ifdef CONFIG_XFRM_OFFLOAD
> +#ifdef CONFIG_IXGBE_IPSEC
>   	if (skb->sp && !ixgbe_ipsec_tx(tx_ring, first, &ipsec_tx))
>   		goto out_drop;
>   #endif
> @@ -10190,7 +10190,7 @@ ixgbe_features_check(struct sk_buff *skb, struct net_device *dev,
>   	 * the TSO, so it's the exception.
>   	 */
>   	if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID)) {
> -#ifdef CONFIG_XFRM_OFFLOAD
> +#ifdef CONFIG_IXGBE_IPSEC
>   		if (!skb->sp)
>   #endif
>   			features &= ~NETIF_F_TSO;
> @@ -10883,7 +10883,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	if (hw->mac.type >= ixgbe_mac_82599EB)
>   		netdev->features |= NETIF_F_SCTP_CRC;
>   
> -#ifdef CONFIG_XFRM_OFFLOAD
> +#ifdef CONFIG_IXGBE_IPSEC
>   #define IXGBE_ESP_FEATURES	(NETIF_F_HW_ESP | \
>   				 NETIF_F_HW_ESP_TX_CSUM | \
>   				 NETIF_F_GSO_ESP)
> diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
> index 4a9ee2d83158..140270a13d54 100644
> --- a/net/xfrm/Kconfig
> +++ b/net/xfrm/Kconfig
> @@ -8,7 +8,6 @@ config XFRM
>   
>   config XFRM_OFFLOAD
>          bool
> -       depends on XFRM
>   
>   config XFRM_ALGO
>   	tristate
> 
