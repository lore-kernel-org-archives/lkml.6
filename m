Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7F1C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56E82075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="K6QH8P/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56E82075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeJLGum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:50:42 -0400
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:56246 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbeJLGum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1539300071; x=1570836071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v9GNjcud1LlLYO0a1qUvykNJMtmwO50g/fES9iVkRkI=;
  b=K6QH8P/EXRR99GQzo11CTn518SpuDrHq8qZLfhIoch4JZ401INqVD3VR
   YF8ZBOx6UjA7RdyCwO2SlgsVvC5zjN38QRWd9QscnxzVmDrEeFmOI83IS
   aPpvHVW0D8GLPQxNYQbyJSWdTvtjeCatNklIC/CT6e12z/KD55+H/FeLz
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EgAABF2r9bhiWd50NiHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBgmltEigKhzWETF+MFIFSgiqUVoF6CwEBG4EVgzwChHc0DQ0?=
 =?us-ascii?q?BAwEBAgEBAgEBAhABAQETCwgpIwyCNiKBRl89AQEBAQIBEhUTPwULAgEINhB?=
 =?us-ascii?q?XAgQBDQUIGoJ+AYF5CJthiVcBAQGBaDODcBEBhWGNXIESgxKER4YPAoEoAYc?=
 =?us-ascii?q?uHhuGX44hBgEChlKDFYZlH4FPhGuJV5JfAYMLAgQCBAUCFIFCN4FXcIFugU4?=
 =?us-ascii?q?Jgh0OCYMgikIBNW+JZoEugR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EgAABF2r9bhiWd50NiHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?mltEigKhzWETF+MFIFSgiqUVoF6CwEBG4EVgzwChHc0DQ0BAwEBAgEBAgEBA?=
 =?us-ascii?q?hABAQETCwgpIwyCNiKBRl89AQEBAQIBEhUTPwULAgEINhBXAgQBDQUIGoJ+A?=
 =?us-ascii?q?YF5CJthiVcBAQGBaDODcBEBhWGNXIESgxKER4YPAoEoAYcuHhuGX44hBgECh?=
 =?us-ascii?q?lKDFYZlH4FPhGuJV5JfAYMLAgQCBAUCFIFCN4FXcIFugU4Jgh0OCYMgikIBN?=
 =?us-ascii?q?W+JZoEugR8BAQ?=
Received: from mx0b-00154901.pphosted.com (HELO mx0a-00154901.pphosted.com) ([67.231.157.37])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2018 18:21:10 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BNILCY111057;
        Thu, 11 Oct 2018 19:21:10 -0400
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2n2bxjs7nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Oct 2018 19:21:10 -0400
From:   <Justin.Lee1@Dell.com>
Received: from ausc60ps301.us.dell.com ([143.166.148.206])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Oct 2018 05:21:05 +0600
X-LoopCount0: from 10.166.135.96
X-IronPort-AV: E=Sophos;i="5.54,370,1534827600"; 
   d="scan'208";a="1207789178"
To:     <vijaykhemka@fb.com>, <sam@mendozajonas.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <openbmc@lists.ozlabs.org>, <joel@jms.id.au>,
        <linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH net-next v3 1/2] net/ncsi: Add NCSI Broadcom OEM command
Thread-Topic: [PATCH net-next v3 1/2] net/ncsi: Add NCSI Broadcom OEM command
Thread-Index: AQHUYbcBGf4nn72eYUmnDypnXJq3iqUarLog
Date:   Thu, 11 Oct 2018 23:21:06 +0000
Message-ID: <fcd53ec5b915431087b7100432bece2f@AUSX13MPS302.AMER.DELL.COM>
References: <20181011230518.3204700-1-vijaykhemka@fb.com>
In-Reply-To: <20181011230518.3204700-1-vijaykhemka@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,

Please order all local variable declarations from longest to shortest
line as instructed by Dave.

Thanks,
Justin


> This patch adds OEM Broadcom commands and response handling. It also
> defines OEM Get MAC Address handler to get and configure the device.
>=20
> ncsi_oem_gma_handler_bcm: This handler send NCSI broadcom command for
> getting mac address.
> ncsi_rsp_handler_oem_bcm: This handles response received for all
> broadcom OEM commands.
> ncsi_rsp_handler_oem_bcm_gma: This handles get mac address response and
> set it to device.
>=20
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  net/ncsi/Kconfig       |  6 ++++
>  net/ncsi/internal.h    |  8 +++++
>  net/ncsi/ncsi-manage.c | 70 ++++++++++++++++++++++++++++++++++++++++++
>  net/ncsi/ncsi-pkt.h    |  8 +++++
>  net/ncsi/ncsi-rsp.c    | 40 +++++++++++++++++++++++-
>  5 files changed, 131 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/ncsi/Kconfig b/net/ncsi/Kconfig
> index 08a8a6031fd7..7f2b46108a24 100644
> --- a/net/ncsi/Kconfig
> +++ b/net/ncsi/Kconfig
> @@ -10,3 +10,9 @@ config NET_NCSI
>  	  support. Enable this only if your system connects to a network
>  	  device via NCSI and the ethernet driver you're using supports
>  	  the protocol explicitly.
> +config NCSI_OEM_CMD_GET_MAC
> +	bool "Get NCSI OEM MAC Address"
> +	depends on NET_NCSI
> +	---help---
> +	  This allows to get MAC address from NCSI firmware and set them back t=
o
> +		controller.
> diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
> index 3d0a33b874f5..45883b32790e 100644
> --- a/net/ncsi/internal.h
> +++ b/net/ncsi/internal.h
> @@ -71,6 +71,13 @@ enum {
>  /* OEM Vendor Manufacture ID */
>  #define NCSI_OEM_MFR_MLX_ID             0x8119
>  #define NCSI_OEM_MFR_BCM_ID             0x113d
> +/* Broadcom specific OEM Command */
> +#define NCSI_OEM_BCM_CMD_GMA            0x01   /* CMD ID for Get MAC */
> +/* OEM Command payload lengths*/
> +#define NCSI_OEM_BCM_CMD_GMA_LEN        12
> +/* Mac address offset in OEM response */
> +#define BCM_MAC_ADDR_OFFSET             28
> +
> =20
>  struct ncsi_channel_version {
>  	u32 version;		/* Supported BCD encoded NCSI version */
> @@ -240,6 +247,7 @@ enum {
>  	ncsi_dev_state_probe_dp,
>  	ncsi_dev_state_config_sp	=3D 0x0301,
>  	ncsi_dev_state_config_cis,
> +	ncsi_dev_state_config_oem_gma,
>  	ncsi_dev_state_config_clear_vids,
>  	ncsi_dev_state_config_svf,
>  	ncsi_dev_state_config_ev,
> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 091284760d21..75504ccd1b95 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -635,6 +635,39 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, st=
ruct ncsi_channel *nc,
>  	return 0;
>  }
> =20
> +#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
> +
> +/* NCSI OEM Command APIs */
> +static void ncsi_oem_gma_handler_bcm(struct ncsi_cmd_arg *nca)
> +{
> +	int ret =3D 0;
> +	unsigned char data[NCSI_OEM_BCM_CMD_GMA_LEN];
> +
> +	nca->payload =3D NCSI_OEM_BCM_CMD_GMA_LEN;
> +
> +	memset(data, 0, NCSI_OEM_BCM_CMD_GMA_LEN);
> +	*(unsigned int *)data =3D ntohl(NCSI_OEM_MFR_BCM_ID);
> +	data[5] =3D NCSI_OEM_BCM_CMD_GMA;
> +
> +	nca->data =3D data;
> +
> +	ret =3D ncsi_xmit_cmd(nca);
> +	if (ret)
> +		netdev_err(nca->ndp->ndev.dev,
> +			   "NCSI: Failed to transmit cmd 0x%x during configure\n",
> +			   nca->type);
> +}
> +
> +/* OEM Command handlers initialization */
> +static struct ncsi_oem_gma_handler {
> +	unsigned int	mfr_id;
> +	void		(*handler)(struct ncsi_cmd_arg *nca);
> +} ncsi_oem_gma_handlers[] =3D {
> +	{ NCSI_OEM_MFR_BCM_ID, ncsi_oem_gma_handler_bcm }
> +};
> +
> +#endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
> +
>  static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
>  {
>  	struct ncsi_dev *nd =3D &ndp->ndev;
> @@ -685,6 +718,43 @@ static void ncsi_configure_channel(struct ncsi_dev_p=
riv *ndp)
>  			goto error;
>  		}
> =20
> +#if IS_ENABLED(CONFIG_NCSI_OEM_CMD_GET_MAC)
> +		nd->state =3D ncsi_dev_state_config_oem_gma;
> +		break;
> +	case ncsi_dev_state_config_oem_gma:
> +		nca.type =3D NCSI_PKT_CMD_OEM;
> +		nca.package =3D np->id;
> +		nca.channel =3D nc->id;
> +		ndp->pending_req_num =3D 1;
> +
> +		/* Check for manufacturer id and Find the handler */
> +		struct ncsi_oem_gma_handler *nch =3D NULL;
> +		int i;
> +
> +		for (i =3D 0; i < ARRAY_SIZE(ncsi_oem_gma_handlers); i++) {
> +			if (ncsi_oem_gma_handlers[i].mfr_id =3D=3D
> +					nc->version.mf_id) {
> +				if (ncsi_oem_gma_handlers[i].handler)
> +					nch =3D &ncsi_oem_gma_handlers[i];
> +				else
> +					nch =3D NULL;
> +
> +				break;
> +			}
> +		}
> +
> +		if (!nch) {
> +			netdev_err(ndp->ndev.dev, "No handler available for GMA with MFR-ID (=
0x%x)\n",
> +				   nc->version.mf_id);
> +			nd->state =3D ncsi_dev_state_config_clear_vids;
> +			schedule_work(&ndp->work);
> +			break;
> +		}
> +
> +		/* Get Mac address from NCSI device */
> +		nch->handler(&nca);
> +#endif /* CONFIG_NCSI_OEM_CMD_GET_MAC */
> +
>  		nd->state =3D ncsi_dev_state_config_clear_vids;
>  		break;
>  	case ncsi_dev_state_config_clear_vids:
> diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
> index 0f2087c8d42a..4d3f06be38bd 100644
> --- a/net/ncsi/ncsi-pkt.h
> +++ b/net/ncsi/ncsi-pkt.h
> @@ -165,6 +165,14 @@ struct ncsi_rsp_oem_pkt {
>  	unsigned char           data[];      /* Payload data      */
>  };
> =20
> +/* Broadcom Response Data */
> +struct ncsi_rsp_oem_bcm_pkt {
> +	unsigned char           ver;         /* Payload Version   */
> +	unsigned char           type;        /* OEM Command type  */
> +	__be16                  len;         /* Payload Length    */
> +	unsigned char           data[];      /* Cmd specific Data */
> +};
> +
>  /* Get Link Status */
>  struct ncsi_rsp_gls_pkt {
>  	struct ncsi_rsp_pkt_hdr rsp;        /* Response header   */
> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index d66b34749027..31672e967db2 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -596,12 +596,50 @@ static int ncsi_rsp_handler_snfc(struct ncsi_reques=
t *nr)
>  	return 0;
>  }
> =20
> +/* Response handler for Broadcom command Get Mac Address */
> +static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
> +{
> +	struct ncsi_rsp_oem_pkt *rsp;
> +	struct ncsi_dev_priv *ndp =3D nr->ndp;
> +	struct net_device *ndev =3D ndp->ndev.dev;
> +	int ret =3D 0;
> +	const struct net_device_ops *ops =3D ndev->netdev_ops;
> +	struct sockaddr saddr;
> +
> +	/* Get the response header */
> +	rsp =3D (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
> +
> +	saddr.sa_family =3D ndev->type;
> +	ndev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE;
> +	memcpy(saddr.sa_data, &rsp->data[BCM_MAC_ADDR_OFFSET], ETH_ALEN);
> +	ret =3D ops->ndo_set_mac_address(ndev, &saddr);
> +	if (ret < 0)
> +		netdev_warn(ndev, "NCSI: Writing mac address to device failed\n");
> +
> +	return ret;
> +}
> +
> +/* Response handler for Broadcom card */
> +static int ncsi_rsp_handler_oem_bcm(struct ncsi_request *nr)
> +{
> +	struct ncsi_rsp_oem_pkt *rsp;
> +	struct ncsi_rsp_oem_bcm_pkt *bcm;
> +
> +	/* Get the response header */
> +	rsp =3D (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
> +	bcm =3D (struct ncsi_rsp_oem_bcm_pkt *)(rsp->data);
> +
> +	if (bcm->type =3D=3D NCSI_OEM_BCM_CMD_GMA)
> +		return ncsi_rsp_handler_oem_bcm_gma(nr);
> +	return 0;
> +}
> +
>  static struct ncsi_rsp_oem_handler {
>  	unsigned int	mfr_id;
>  	int		(*handler)(struct ncsi_request *nr);
>  } ncsi_rsp_oem_handlers[] =3D {
>  	{ NCSI_OEM_MFR_MLX_ID, NULL },
> -	{ NCSI_OEM_MFR_BCM_ID, NULL }
> +	{ NCSI_OEM_MFR_BCM_ID, ncsi_rsp_handler_oem_bcm }
>  };
> =20
>  /* Response handler for OEM command */
> --=20
> 2.17.1
>
