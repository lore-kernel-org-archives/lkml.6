Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA94C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2CF20659
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="l2PCjHsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2CF20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeJKGAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:00:34 -0400
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:30839 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725969AbeJKGAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1539210949; x=1570746949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f7bpd4qQf46TH0iG07xKmx1W/h0b93/3bC/FyJxQKiM=;
  b=l2PCjHskQRpL6MokO2CcdyqnkUXC8VQAHQGpiFCJHva+B6VLuv1B6AZh
   1MqJafH5nTf1SmGNSvQvxwO7QeECGSkb7UGqyULB1RuJZB5LVJMEc/XvM
   l5Rzpgl9vDvWzDPdt1G/QgxHw3x2xnVOlp6ZdLKZFqgbw90nbByUAbhIT
   s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EPAABkfr5bhyeV50NjHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBg1YSKAqMAV+NZHqWBRSBZgsBAYRsAoRyNA0NAQMBAQIBAQI?=
 =?us-ascii?q?BAQIQAQEBFQkIKS+CNiKCYgEBAQECARIIDRM/BQsCAQg2EFcCBAENBQgagn8?=
 =?us-ascii?q?BgXkIm2mJVwEBAYFoM4lgjVKBEQGCXTWEZ4VvAoEoAZxdBgECiWQBBYZfH5A?=
 =?us-ascii?q?LlWUCBAIEBQIUgUI3gVdwUIEegU6CJg4JEY4Hb4xGgR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EPAABkfr5bhyeV50NjHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?1YSKAqMAV+NZHqWBRSBZgsBAYRsAoRyNA0NAQMBAQIBAQIBAQIQAQEBFQkIK?=
 =?us-ascii?q?S+CNiKCYgEBAQECARIIDRM/BQsCAQg2EFcCBAENBQgagn8BgXkIm2mJVwEBA?=
 =?us-ascii?q?YFoM4lgjVKBEQGCXTWEZ4VvAoEoAZxdBgECiWQBBYZfH5ALlWUCBAIEBQIUg?=
 =?us-ascii?q?UI3gVdwUIEegU6CJg4JEY4Hb4xGgR8BAQ?=
Received: from mx0a-00154901.pphosted.com (HELO mx0b-00154901.pphosted.com) ([67.231.149.39])
  by esa5.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Oct 2018 17:35:48 -0500
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9AMXmkN013752;
        Wed, 10 Oct 2018 18:36:19 -0400
Received: from esa1.dell-outbound2.iphmx.com (esa1.dell-outbound2.iphmx.com [68.232.153.201])
        by mx0b-00154901.pphosted.com with ESMTP id 2n1sk286cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Oct 2018 18:36:18 -0400
From:   <Justin.Lee1@Dell.com>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Oct 2018 04:36:12 +0600
X-LoopCount0: from 10.166.135.91
X-IronPort-AV: E=Sophos;i="5.54,366,1534827600"; 
   d="scan'208";a="1310437063"
To:     <sam@mendozajonas.com>, <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
Subject: RE: [RFC PATCH 2/2] net/ncsi: Configure multi-package, multi-channel
 modes with failover
Thread-Topic: [RFC PATCH 2/2] net/ncsi: Configure multi-package, multi-channel
 modes with failover
Thread-Index: AQHUX4RyYJjtPwgbwE6mb3hPBRiDwKUXHQkQ
Date:   Wed, 10 Oct 2018 22:36:15 +0000
Message-ID: <d97bb52a060a40cf8e03a49eb82a285f@AUSX13MPS302.AMER.DELL.COM>
References: <20181009035815.5246-1-sam@mendozajonas.com>
 <20181009035815.5246-2-sam@mendozajonas.com>
In-Reply-To: <20181009035815.5246-2-sam@mendozajonas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-10_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810100209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

I am still testing your change and have some comments below.

Thanks,
Justin


> This patch extends the ncsi-netlink interface with two new commands and
> three new attributes to configure multiple packages and/or channels at
> once, and configure specific failover modes.
>=20
> NCSI_CMD_SET_PACKAGE mask and NCSI_CMD_SET_CHANNEL_MASK set a whitelist
> of packages or channels allowed to be configured with the
> NCSI_ATTR_PACKAGE_MASK and NCSI_ATTR_CHANNEL_MASK attributes
> respectively. If one of these whitelists is set only packages or
> channels matching the whitelist are considered for the channel queue in
> ncsi_choose_active_channel().
>=20
> These commands may also use the NCSI_ATTR_MULTI_FLAG to signal that
> multiple packages or channels may be configured simultaneously. NCSI
> hardware arbitration (HWA) must be available in order to enable
> multi-package mode. Multi-channel mode is always available.
>=20
> If the NCSI_ATTR_CHANNEL_ID attribute is present in the
> NCSI_CMD_SET_CHANNEL_MASK command the it sets the preferred channel as
> with the NCSI_CMD_SET_INTERFACE command. The combination of preferred
> channel and channel whitelist defines a primary channel and the allowed
> failover channels.
> If the NCSI_ATTR_MULTI_FLAG attribute is also present then the preferred
> channel is configured for Tx/Rx and the other channels are enabled only
> for Rx.
>=20
> Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> ---
>  include/uapi/linux/ncsi.h |  16 +++
>  net/ncsi/internal.h       |  11 +-
>  net/ncsi/ncsi-aen.c       |   2 +-
>  net/ncsi/ncsi-manage.c    | 138 ++++++++++++++++--------
>  net/ncsi/ncsi-netlink.c   | 217 +++++++++++++++++++++++++++++++++-----
>  net/ncsi/ncsi-rsp.c       |   2 +-
>  6 files changed, 312 insertions(+), 74 deletions(-)
>=20
> diff --git a/include/uapi/linux/ncsi.h b/include/uapi/linux/ncsi.h
> index 4c292ecbb748..035fba1693f9 100644
> --- a/include/uapi/linux/ncsi.h
> +++ b/include/uapi/linux/ncsi.h
> @@ -23,6 +23,13 @@
>   *	optionally the preferred NCSI_ATTR_CHANNEL_ID.
>   * @NCSI_CMD_CLEAR_INTERFACE: clear any preferred package/channel combin=
ation.
>   *	Requires NCSI_ATTR_IFINDEX.
> + * @NCSI_CMD_SET_PACKAGE_MASK: set a whitelist of allowed packages.
> + * @NCSI_CMD_SET_PACKAGE_MASK: set a whitelist of allowed channels.
> + *	Requires NCSI_ATTR_IFINDEX and NCSI_ATTR_PACKAGE_MASK.
> + * @NCSI_CMD_SET_PACKAGE_MASK: set a whitelist of allowed channels.
> + *	Requires NCSI_ATTR_IFINDEX, NCSI_ATTR_PACKAGE_ID, and
> + *	NCSI_ATTR_CHANNEL_MASK. If NCSI_ATTR_CHANNEL_ID is present it sets
> + *	the primary channel.
>   * @NCSI_CMD_MAX: highest command number
>   */

There are some typo in the description.
* @NCSI_CMD_SET_PACKAGE_MASK: set a whitelist of allowed packages.
 *	Requires NCSI_ATTR_IFINDEX and NCSI_ATTR_PACKAGE_MASK.
 * @NCSI_CMD_SET_CHANNEL_MASK: set a whitelist of allowed channels.
 *	Requires NCSI_ATTR_IFINDEX, NCSI_ATTR_PACKAGE_ID, and
 *	NCSI_ATTR_CHANNEL_MASK. If NCSI_ATTR_CHANNEL_ID is present it sets
 *	the primary channel.

>  enum ncsi_nl_commands {
> @@ -30,6 +37,8 @@ enum ncsi_nl_commands {
>  	NCSI_CMD_PKG_INFO,
>  	NCSI_CMD_SET_INTERFACE,
>  	NCSI_CMD_CLEAR_INTERFACE,
> +	NCSI_CMD_SET_PACKAGE_MASK,
> +	NCSI_CMD_SET_CHANNEL_MASK,
> =20
>  	__NCSI_CMD_AFTER_LAST,
>  	NCSI_CMD_MAX =3D __NCSI_CMD_AFTER_LAST - 1
> @@ -43,6 +52,10 @@ enum ncsi_nl_commands {
>   * @NCSI_ATTR_PACKAGE_LIST: nested array of NCSI_PKG_ATTR attributes
>   * @NCSI_ATTR_PACKAGE_ID: package ID
>   * @NCSI_ATTR_CHANNEL_ID: channel ID
> + * @NCSI_ATTR_MULTI_FLAG: flag to signal that multi-mode should be enabl=
ed with
> + *	NCSI_CMD_SET_PACKAGE_MASK or NCSI_CMD_SET_CHANNEL_MASK.
> + * @NCSI_ATTR_PACKAGE_MASK: 32-bit mask of allowed packages.
> + * @NCSI_ATTR_CHANNEL_MASK: 32-bit mask of allowed channels.
>   * @NCSI_ATTR_MAX: highest attribute number
>   */
>  enum ncsi_nl_attrs {
> @@ -51,6 +64,9 @@ enum ncsi_nl_attrs {
>  	NCSI_ATTR_PACKAGE_LIST,
>  	NCSI_ATTR_PACKAGE_ID,
>  	NCSI_ATTR_CHANNEL_ID,
> +	NCSI_ATTR_MULTI_FLAG,
> +	NCSI_ATTR_PACKAGE_MASK,
> +	NCSI_ATTR_CHANNEL_MASK,

Is there a case that we might set these two masks at the same time?
If not, maybe we can just have one generic MASK attribute.

> =20
>  	__NCSI_ATTR_AFTER_LAST,
>  	NCSI_ATTR_MAX =3D __NCSI_ATTR_AFTER_LAST - 1
> diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
> index 3d0a33b874f5..8437474d0a78 100644
> --- a/net/ncsi/internal.h
> +++ b/net/ncsi/internal.h
> @@ -213,6 +213,10 @@ struct ncsi_package {
>  	unsigned int         channel_num; /* Number of channels     */
>  	struct list_head     channels;    /* List of chanels        */
>  	struct list_head     node;        /* Form list of packages  */
> +
> +	bool                 multi_channel; /* Enable multiple channels  */
> +	u32                  channel_whitelist; /* Channels to configure */
> +	struct ncsi_channel  *preferred_channel; /* Primary channel      */
>  };
> =20
>  struct ncsi_request {
> @@ -280,8 +284,6 @@ struct ncsi_dev_priv {
>  	unsigned int        package_num;     /* Number of packages         */
>  	struct list_head    packages;        /* List of packages           */
>  	struct ncsi_channel *hot_channel;    /* Channel was ever active    */
> -	struct ncsi_package *force_package;  /* Force a specific package   */
> -	struct ncsi_channel *force_channel;  /* Force a specific channel   */
>  	struct ncsi_request requests[256];   /* Request table              */
>  	unsigned int        request_id;      /* Last used request ID       */
>  #define NCSI_REQ_START_IDX	1
> @@ -294,6 +296,9 @@ struct ncsi_dev_priv {
>  	struct list_head    node;            /* Form NCSI device list      */
>  #define NCSI_MAX_VLAN_VIDS	15
>  	struct list_head    vlan_vids;       /* List of active VLAN IDs */
> +
> +	bool                multi_package;   /* Enable multiple packages   */
> +	u32                 package_whitelist; /* Packages to configure    */
>  };
> =20
>  struct ncsi_cmd_arg {
> @@ -345,6 +350,8 @@ struct ncsi_request *ncsi_alloc_request(struct ncsi_d=
ev_priv *ndp,
>  void ncsi_free_request(struct ncsi_request *nr);
>  struct ncsi_dev *ncsi_find_dev(struct net_device *dev);
>  int ncsi_process_next_channel(struct ncsi_dev_priv *ndp);
> +bool ncsi_channel_is_last(struct ncsi_dev_priv *ndp,
> +			  struct ncsi_channel *channel);
> =20
>  /* Packet handlers */
>  u32 ncsi_calculate_checksum(unsigned char *data, int len);
> diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
> index 65f47a648be3..eac56aee30c4 100644
> --- a/net/ncsi/ncsi-aen.c
> +++ b/net/ncsi/ncsi-aen.c
> @@ -86,7 +86,7 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *n=
dp,
>  	    !(state =3D=3D NCSI_CHANNEL_ACTIVE && !(data & 0x1)))
>  		return 0;
> =20
> -	if (state =3D=3D NCSI_CHANNEL_ACTIVE)
> +	if (state =3D=3D NCSI_CHANNEL_ACTIVE && ncsi_channel_is_last(ndp, nc))
>  		ndp->flags |=3D NCSI_DEV_RESHUFFLE;
> =20
>  	ncsi_stop_channel_monitor(nc);
> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 665bee25ec44..6a55df700bcb 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -27,6 +27,24 @@
>  LIST_HEAD(ncsi_dev_list);
>  DEFINE_SPINLOCK(ncsi_dev_lock);
> =20
> +/* Returns true if the given channel is the last channel available */
> +bool ncsi_channel_is_last(struct ncsi_dev_priv *ndp,
> +			  struct ncsi_channel *channel)
> +{
> +	struct ncsi_package *np;
> +	struct ncsi_channel *nc;
> +
> +	NCSI_FOR_EACH_PACKAGE(ndp, np)
> +		NCSI_FOR_EACH_CHANNEL(np, nc) {
> +			if (nc =3D=3D channel)
> +				continue;
> +			if (nc->state =3D=3D NCSI_CHANNEL_ACTIVE)
> +				return false;
> +		}
> +
> +	return true;
> +}
> +
>  static void ncsi_report_link(struct ncsi_dev_priv *ndp, bool force_down)
>  {
>  	struct ncsi_dev *nd =3D &ndp->ndev;
> @@ -266,6 +284,7 @@ struct ncsi_package *ncsi_add_package(struct ncsi_dev=
_priv *ndp,
>  	np->ndp =3D ndp;
>  	spin_lock_init(&np->lock);
>  	INIT_LIST_HEAD(&np->channels);
> +	np->channel_whitelist =3D UINT_MAX;
> =20
>  	spin_lock_irqsave(&ndp->lock, flags);
>  	tmp =3D ncsi_find_package(ndp, id);
> @@ -633,6 +652,34 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, st=
ruct ncsi_channel *nc,
>  	return 0;
>  }
> =20
> +/* Determine if a given channel should be the Tx channel */
> +bool ncsi_channel_is_tx(struct ncsi_dev_priv *ndp, struct ncsi_channel *=
nc)
> +{
> +	struct ncsi_package *np =3D nc->package;
> +	struct ncsi_channel *channel;
> +	struct ncsi_channel_mode *ncm;
> +
> +	NCSI_FOR_EACH_CHANNEL(np, channel) {
> +		ncm =3D &channel->modes[NCSI_MODE_TX_ENABLE];
> +		/* Another channel is already Tx */
> +		if (ncm->enable)
> +			return false;
> +	}
> +
> +	if (!np->preferred_channel)
> +		return true;
> +
> +	if (np->preferred_channel =3D=3D nc)
> +		return true;
> +
> +	/* The preferred channel is not in the queue and not active */
> +	if (list_empty(&np->preferred_channel->link) &&
> +	    np->preferred_channel->state !=3D NCSI_CHANNEL_ACTIVE)
> +		return true;
> +
> +	return false;
> +}
> +
>  static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
>  {
>  	struct ncsi_dev *nd =3D &ndp->ndev;
> @@ -745,18 +792,22 @@ static void ncsi_configure_channel(struct ncsi_dev_=
priv *ndp)
>  		} else if (nd->state =3D=3D ncsi_dev_state_config_ebf) {
>  			nca.type =3D NCSI_PKT_CMD_EBF;
>  			nca.dwords[0] =3D nc->caps[NCSI_CAP_BC].cap;
> -			nd->state =3D ncsi_dev_state_config_ecnt;
> +			if (ncsi_channel_is_tx(ndp, nc))
> +				nd->state =3D ncsi_dev_state_config_ecnt;
> +			else
> +				nd->state =3D ncsi_dev_state_config_ec;
>  #if IS_ENABLED(CONFIG_IPV6)
>  			if (ndp->inet6_addr_num > 0 &&
>  			    (nc->caps[NCSI_CAP_GENERIC].cap &
>  			     NCSI_CAP_GENERIC_MC))
>  				nd->state =3D ncsi_dev_state_config_egmf;
> -			else
> -				nd->state =3D ncsi_dev_state_config_ecnt;
>  		} else if (nd->state =3D=3D ncsi_dev_state_config_egmf) {
>  			nca.type =3D NCSI_PKT_CMD_EGMF;
>  			nca.dwords[0] =3D nc->caps[NCSI_CAP_MC].cap;
> -			nd->state =3D ncsi_dev_state_config_ecnt;
> +			if (ncsi_channel_is_tx(ndp, nc))
> +				nd->state =3D ncsi_dev_state_config_ecnt;
> +			else
> +				nd->state =3D ncsi_dev_state_config_ec;
>  #endif /* CONFIG_IPV6 */
>  		} else if (nd->state =3D=3D ncsi_dev_state_config_ecnt) {
>  			nca.type =3D NCSI_PKT_CMD_ECNT;
> @@ -840,43 +891,35 @@ static void ncsi_configure_channel(struct ncsi_dev_=
priv *ndp)
> =20
>  static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
>  {
> -	struct ncsi_package *np, *force_package;
> -	struct ncsi_channel *nc, *found, *hot_nc, *force_channel;
> +	struct ncsi_package *np;
> +	struct ncsi_channel *nc, *found, *hot_nc;
>  	struct ncsi_channel_mode *ncm;
> -	unsigned long flags;
> +	unsigned long flags, cflags;
> +	bool with_link;
> =20
>  	spin_lock_irqsave(&ndp->lock, flags);
>  	hot_nc =3D ndp->hot_channel;
> -	force_channel =3D ndp->force_channel;
> -	force_package =3D ndp->force_package;
>  	spin_unlock_irqrestore(&ndp->lock, flags);
> =20
> -	/* Force a specific channel whether or not it has link if we have been
> -	 * configured to do so
> -	 */
> -	if (force_package && force_channel) {
> -		found =3D force_channel;
> -		ncm =3D &found->modes[NCSI_MODE_LINK];
> -		if (!(ncm->data[2] & 0x1))
> -			netdev_info(ndp->ndev.dev,
> -				    "NCSI: Channel %u forced, but it is link down\n",
> -				    found->id);
> -		goto out;
> -	}
> -
> -	/* The search is done once an inactive channel with up
> -	 * link is found.
> +	/* By default the search is done once an inactive channel with up
> +	 * link is found, unless a preferred channel is set.
> +	 * If multi_package or multi_channel are configured all channels in the
> +	 * whitelist with link are added to the channel queue.
>  	 */
>  	found =3D NULL;
> +	with_link =3D false;
>  	NCSI_FOR_EACH_PACKAGE(ndp, np) {
> -		if (ndp->force_package && np !=3D ndp->force_package)
> +		if (!(ndp->package_whitelist & (0x1 << np->id)))
>  			continue;
>  		NCSI_FOR_EACH_CHANNEL(np, nc) {
> -			spin_lock_irqsave(&nc->lock, flags);
> +			if (!(np->channel_whitelist & (0x1 << nc->id)))
> +				continue;
> +
> +			spin_lock_irqsave(&nc->lock, cflags);
> =20
>  			if (!list_empty(&nc->link) ||
>  			    nc->state !=3D NCSI_CHANNEL_INACTIVE) {
> -				spin_unlock_irqrestore(&nc->lock, flags);
> +				spin_unlock_irqrestore(&nc->lock, cflags);
>  				continue;
>  			}
> =20
> @@ -888,32 +931,42 @@ static int ncsi_choose_active_channel(struct ncsi_d=
ev_priv *ndp)
> =20
>  			ncm =3D &nc->modes[NCSI_MODE_LINK];
>  			if (ncm->data[2] & 0x1) {

This data will not be updated if the channel monitor for it is not running.
If I move the cable from the current configured channel to the other channe=
l,
NC-SI module will not detect the link status as the other channel is not co=
nfigured
and AEN will not happen.
Is it per design that NC-SI module will always use the first interface with=
 the link?

> -				spin_unlock_irqrestore(&nc->lock, flags);
>  				found =3D nc;
> -				goto out;
> +				with_link =3D true;
> +
> +				spin_lock_irqsave(&ndp->lock, flags);
> +				list_add_tail_rcu(&found->link,
> +						  &ndp->channel_queue);
> +				spin_unlock_irqrestore(&ndp->lock, flags);
> +
> +				netdev_dbg(ndp->ndev.dev,
> +					   "NCSI: Channel %u added to queue (link %s)\n",
> +					   found->id,
> +					   ncm->data[2] & 0x1 ? "up" : "down");
>  			}
> +			spin_unlock_irqrestore(&nc->lock, cflags);
> =20
> -			spin_unlock_irqrestore(&nc->lock, flags);
> +			if (with_link && !np->multi_channel)
> +				break;
>  		}
> +		if (with_link && !ndp->multi_package)
> +			break;
>  	}
> =20
> -	if (!found) {
> +	if (!with_link && found) {
> +		netdev_info(ndp->ndev.dev,
> +			    "NCSI: No channel with link found, configuring channel %u\n",
> +			    found->id);
> +		spin_lock_irqsave(&ndp->lock, flags);
> +		list_add_tail_rcu(&found->link, &ndp->channel_queue);
> +		spin_unlock_irqrestore(&ndp->lock, flags);
> +	} else if (!found) {
>  		netdev_warn(ndp->ndev.dev,
> -			    "NCSI: No channel found with link\n");
> +			    "NCSI: No channel found to configure!\n");
>  		ncsi_report_link(ndp, true);
>  		return -ENODEV;
>  	}
> =20
> -	ncm =3D &found->modes[NCSI_MODE_LINK];
> -	netdev_dbg(ndp->ndev.dev,
> -		   "NCSI: Channel %u added to queue (link %s)\n",
> -		   found->id, ncm->data[2] & 0x1 ? "up" : "down");
> -
> -out:
> -	spin_lock_irqsave(&ndp->lock, flags);
> -	list_add_tail_rcu(&found->link, &ndp->channel_queue);
> -	spin_unlock_irqrestore(&ndp->lock, flags);
> -
>  	return ncsi_process_next_channel(ndp);
>  }
> =20
> @@ -1428,6 +1481,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_devic=
e *dev,
>  	INIT_LIST_HEAD(&ndp->channel_queue);
>  	INIT_LIST_HEAD(&ndp->vlan_vids);
>  	INIT_WORK(&ndp->work, ncsi_dev_work);
> +	ndp->package_whitelist =3D UINT_MAX;
> =20
>  	/* Initialize private NCSI device */
>  	spin_lock_init(&ndp->lock);
> diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
> index 32cb7751d216..33a091e6f466 100644
> --- a/net/ncsi/ncsi-netlink.c
> +++ b/net/ncsi/ncsi-netlink.c

Is the following missed in the patch?
static const struct nla_policy ncsi_genl_policy[NCSI_ATTR_MAX + 1] =3D {
...
	[NCSI_ATTR_MULTI_FLAG] =3D	{ .type =3D NLA_FLAG },
	[NCSI_ATTR_PACKAGE_MASK] =3D	{ .type =3D NLA_U32 },
	[NCSI_ATTR_CHANNEL_MASK] =3D	{ .type =3D NLA_U32 },

> @@ -67,7 +67,7 @@ static int ncsi_write_channel_info(struct sk_buff *skb,
>  	nla_put_u32(skb, NCSI_CHANNEL_ATTR_LINK_STATE, m->data[2]);
>  	if (nc->state =3D=3D NCSI_CHANNEL_ACTIVE)
>  		nla_put_flag(skb, NCSI_CHANNEL_ATTR_ACTIVE);
> -	if (ndp->force_channel =3D=3D nc)
> +	if (nc =3D=3D nc->package->preferred_channel)
>  		nla_put_flag(skb, NCSI_CHANNEL_ATTR_FORCED);
> =20
>  	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MAJOR, nc->version.version);
> @@ -112,7 +112,7 @@ static int ncsi_write_package_info(struct sk_buff *sk=
b,
>  		if (!pnest)
>  			return -ENOMEM;
>  		nla_put_u32(skb, NCSI_PKG_ATTR_ID, np->id);
> -		if (ndp->force_package =3D=3D np)
> +		if ((0x1 << np->id) =3D=3D ndp->package_whitelist)
>  			nla_put_flag(skb, NCSI_PKG_ATTR_FORCED);
>  		cnest =3D nla_nest_start(skb, NCSI_PKG_ATTR_CHANNEL_LIST);
>  		if (!cnest) {
> @@ -288,45 +288,54 @@ static int ncsi_set_interface_nl(struct sk_buff *ms=
g, struct genl_info *info)
>  	package_id =3D nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
>  	package =3D NULL;
> =20
> -	spin_lock_irqsave(&ndp->lock, flags);
> -
>  	NCSI_FOR_EACH_PACKAGE(ndp, np)
>  		if (np->id =3D=3D package_id)
>  			package =3D np;
>  	if (!package) {
>  		/* The user has set a package that does not exist */
> -		spin_unlock_irqrestore(&ndp->lock, flags);
>  		return -ERANGE;
>  	}
> =20
>  	channel =3D NULL;
> -	if (!info->attrs[NCSI_ATTR_CHANNEL_ID]) {
> -		/* Allow any channel */
> -		channel_id =3D NCSI_RESERVED_CHANNEL;
> -	} else {
> +	if (info->attrs[NCSI_ATTR_CHANNEL_ID]) {
>  		channel_id =3D nla_get_u32(info->attrs[NCSI_ATTR_CHANNEL_ID]);
>  		NCSI_FOR_EACH_CHANNEL(package, nc)
> -			if (nc->id =3D=3D channel_id)
> +			if (nc->id =3D=3D channel_id) {
>  				channel =3D nc;
> +				break;
> +			}
> +		if (!channel) {
> +			netdev_info(ndp->ndev.dev,
> +				    "NCSI: Channel %u does not exist!\n",
> +				    channel_id);
> +			return -ERANGE;
> +		}
>  	}
> =20
> -	if (channel_id !=3D NCSI_RESERVED_CHANNEL && !channel) {
> -		/* The user has set a channel that does not exist on this
> -		 * package
> -		 */
> -		spin_unlock_irqrestore(&ndp->lock, flags);
> -		netdev_info(ndp->ndev.dev, "NCSI: Channel %u does not exist!\n",
> -			    channel_id);
> -		return -ERANGE;
> -	}
> -
> -	ndp->force_package =3D package;
> -	ndp->force_channel =3D channel;
> +	spin_lock_irqsave(&ndp->lock, flags);
> +	ndp->package_whitelist =3D 0x1 << package->id;
> +	ndp->multi_package =3D false;
>  	spin_unlock_irqrestore(&ndp->lock, flags);
> =20
> -	netdev_info(ndp->ndev.dev, "Set package 0x%x, channel 0x%x%s as preferr=
ed\n",
> -		    package_id, channel_id,
> -		    channel_id =3D=3D NCSI_RESERVED_CHANNEL ? " (any)" : "");
> +	spin_lock_irqsave(&package->lock, flags);
> +	package->multi_channel =3D false;
> +	if (channel) {
> +		package->channel_whitelist =3D 0x1 << channel->id;
> +		package->preferred_channel =3D channel;
> +	} else {
> +		/* Allow any channel */
> +		package->channel_whitelist =3D UINT_MAX;
> +		package->preferred_channel =3D NULL;
> +	}
> +	spin_unlock_irqrestore(&package->lock, flags);
> +
> +	if (channel)
> +		netdev_info(ndp->ndev.dev,
> +			    "Set package 0x%x, channel 0x%x as preferred\n",
> +			    package_id, channel_id);
> +	else
> +		netdev_info(ndp->ndev.dev, "Set package 0x%x as preferred\n",
> +			    package_id);
> =20
>  	/* Bounce the NCSI channel to set changes */
>  	ncsi_stop_dev(&ndp->ndev);
> @@ -338,6 +347,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg,=
 struct genl_info *info)
>  static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info=
 *info)
>  {
>  	struct ncsi_dev_priv *ndp;
> +	struct ncsi_package *np;
>  	unsigned long flags;
> =20
>  	if (!info || !info->attrs)
> @@ -351,11 +361,19 @@ static int ncsi_clear_interface_nl(struct sk_buff *=
msg, struct genl_info *info)
>  	if (!ndp)
>  		return -ENODEV;
> =20
> -	/* Clear any override */
> +	/* Reset any whitelists and disable multi mode */
>  	spin_lock_irqsave(&ndp->lock, flags);
> -	ndp->force_package =3D NULL;
> -	ndp->force_channel =3D NULL;
> +	ndp->package_whitelist =3D UINT_MAX;
> +	ndp->multi_package =3D false;
>  	spin_unlock_irqrestore(&ndp->lock, flags);
> +
> +	NCSI_FOR_EACH_PACKAGE(ndp, np) {
> +		spin_lock_irqsave(&np->lock, flags);
> +		np->multi_channel =3D false;
> +		np->channel_whitelist =3D UINT_MAX;
> +		np->preferred_channel =3D NULL;
> +		spin_unlock_irqrestore(&np->lock, flags);
> +	}
>  	netdev_info(ndp->ndev.dev, "NCSI: Cleared preferred package/channel\n")=
;
> =20
>  	/* Bounce the NCSI channel to set changes */
> @@ -365,6 +383,137 @@ static int ncsi_clear_interface_nl(struct sk_buff *=
msg, struct genl_info *info)
>  	return 0;
>  }
> =20
> +static int ncsi_set_package_mask_nl(struct sk_buff *msg,
> +				    struct genl_info *info)
> +{
> +	struct ncsi_dev_priv *ndp;
> +	unsigned long flags;
> +	int rc;
> +
> +	if (!info || !info->attrs)
> +		return -EINVAL;
> +
> +	if (!info->attrs[NCSI_ATTR_IFINDEX])
> +		return -EINVAL;
> +
> +	if (!info->attrs[NCSI_ATTR_PACKAGE_MASK])
> +		return -EINVAL;
> +
> +	ndp =3D ndp_from_ifindex(get_net(sock_net(msg->sk)),
> +			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
> +	if (!ndp)
> +		return -ENODEV;
> +
> +	spin_lock_irqsave(&ndp->lock, flags);
> +	ndp->package_whitelist =3D
> +		nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_MASK]);
> +
> +	if (nla_get_flag(info->attrs[NCSI_ATTR_MULTI_FLAG])) {
> +		if (ndp->flags & NCSI_DEV_HWA) {
> +			ndp->multi_package =3D true;
> +			rc =3D 0;
> +		} else {
> +			netdev_err(ndp->ndev.dev,
> +				   "NCSI: Can't use multiple packages without HWA\n");
> +			rc =3D -EPERM;
> +		}
> +	} else {
> +		rc =3D 0;
> +	}
> +
> +	spin_unlock_irqrestore(&ndp->lock, flags);
> +
> +	if (!rc) {
> +		/* Bounce the NCSI channel to set changes */
> +		ncsi_stop_dev(&ndp->ndev);
> +		ncsi_start_dev(&ndp->ndev);

Is it possible to delay the restart? If we have two packages, we might send
set_package_mask command once and set_channel_mask command twice.
We will see the unnecessary reconfigurations in a very short period time.

> +	}
> +
> +	return rc;
> +}
> +
> +static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
> +				    struct genl_info *info)
> +{
> +	struct ncsi_package *np, *package;
> +	struct ncsi_channel *nc, *channel;
> +	struct ncsi_dev_priv *ndp;
> +	unsigned long flags;
> +	u32 package_id, channel_id;
> +
> +	if (!info || !info->attrs)
> +		return -EINVAL;
> +
> +	if (!info->attrs[NCSI_ATTR_IFINDEX])
> +		return -EINVAL;
> +
> +	if (!info->attrs[NCSI_ATTR_PACKAGE_ID])
> +		return -EINVAL;
> +
> +	if (!info->attrs[NCSI_ATTR_CHANNEL_MASK])
> +		return -EINVAL;
> +
> +	ndp =3D ndp_from_ifindex(get_net(sock_net(msg->sk)),
> +			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
> +	if (!ndp)
> +		return -ENODEV;
> +
> +	package_id =3D nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
> +	package =3D NULL;
> +	NCSI_FOR_EACH_PACKAGE(ndp, np)
> +		if (np->id =3D=3D package_id) {
> +			package =3D np;
> +			break;
> +		}
> +	if (!package)
> +		return -ERANGE;
> +
> +	spin_lock_irqsave(&package->lock, flags);
> +
> +	channel =3D NULL;
> +	if (info->attrs[NCSI_ATTR_CHANNEL_ID]) {
> +		channel_id =3D nla_get_u32(info->attrs[NCSI_ATTR_CHANNEL_ID]);
> +		NCSI_FOR_EACH_CHANNEL(np, nc)
> +			if (nc->id =3D=3D channel_id) {
> +				channel =3D nc;
> +				break;
> +			}
> +		if (!channel) {
> +			spin_unlock_irqrestore(&package->lock, flags);
> +			return -ERANGE;
> +		}
> +		netdev_dbg(ndp->ndev.dev,
> +			   "NCSI: Channel %u set as preferred channel\n",
> +			   channel->id);
> +	}
> +
> +	package->channel_whitelist =3D
> +		nla_get_u32(info->attrs[NCSI_ATTR_CHANNEL_MASK]);
> +	if (package->channel_whitelist =3D=3D 0)
> +		netdev_dbg(ndp->ndev.dev,
> +			   "NCSI: Package %u set to all channels disabled\n",
> +			   package->id);
> +
> +	package->preferred_channel =3D channel;
> +
> +	if (nla_get_flag(info->attrs[NCSI_ATTR_MULTI_FLAG])) {
> +		package->multi_channel =3D true;
> +		netdev_info(ndp->ndev.dev,
> +			    "NCSI: Multi-channel enabled on package %u\n",
> +			    package_id);
> +	} else {
> +		package->multi_channel =3D false;
> +	}
> +
> +	spin_unlock_irqrestore(&package->lock, flags);
> +
> +	/* Bounce the NCSI channel to set changes */
> +	ncsi_stop_dev(&ndp->ndev);
> +	ncsi_start_dev(&ndp->ndev);

Same question as set_package_mask function.
Is it possible to delay the restart? If we have two packages, we might send
set_package_mask command once and set_channel_mask command twice.
We will see the unnecessary reconfigurations in a very short period time.

> +
> +	return 0;
> +}
> +
>  static const struct genl_ops ncsi_ops[] =3D {
>  	{
>  		.cmd =3D NCSI_CMD_PKG_INFO,
> @@ -385,6 +534,18 @@ static const struct genl_ops ncsi_ops[] =3D {
>  		.doit =3D ncsi_clear_interface_nl,
>  		.flags =3D GENL_ADMIN_PERM,
>  	},
> +	{
> +		.cmd =3D NCSI_CMD_SET_PACKAGE_MASK,
> +		.policy =3D ncsi_genl_policy,
> +		.doit =3D ncsi_set_package_mask_nl,
> +		.flags =3D GENL_ADMIN_PERM,
> +	},
> +	{
> +		.cmd =3D NCSI_CMD_SET_CHANNEL_MASK,
> +		.policy =3D ncsi_genl_policy,
> +		.doit =3D ncsi_set_channel_mask_nl,
> +		.flags =3D GENL_ADMIN_PERM,
> +	},
>  };
> =20
>  static struct genl_family ncsi_genl_family __ro_after_init =3D {
> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index d66b34749027..02ce7626b579 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -241,7 +241,7 @@ static int ncsi_rsp_handler_dcnt(struct ncsi_request =
*nr)
>  	if (!ncm->enable)
>  		return 0;
> =20
> -	ncm->enable =3D 1;
> +	ncm->enable =3D 0;
>  	return 0;
>  }
> =20
> --=20
> 2.19.0


