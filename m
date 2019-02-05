Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23336C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20762080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="EIXlMCkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfBETww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:52:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35266 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbfBETwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:52:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so237324wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 11:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jqoWZiJxlCBxbRRpXBh+xP2OsFHMSzvgfaHB0Sgh3uY=;
        b=EIXlMCkcTZvU1SAZRKmqAVcFwj1Ki4xGMGMGbo7q81aT19n5KocdmULVxB59Zd5nHb
         5So399uW4vGUE5bDn7WtetdhSWh+eHPSLFUpQdSSst8sOTJOy59cUjhddFGAajUfG0Hg
         DrdEVn+3EHAiSrEmafMeCN5ciPrYqkCbKBzpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jqoWZiJxlCBxbRRpXBh+xP2OsFHMSzvgfaHB0Sgh3uY=;
        b=LGblRLP+bdn1VCCqMgoDcVVVzrh4xDZKexsfEeBvd1xh0FJYwcD13hnRuaf/zSPfba
         YrwMpwc167Bj9raZdR/qieVFpSYT6hHlTFqbTrIQqfUadeEMnGy0AUjy/zBRKKcEv6Oc
         fhHN7LvI4dC+bRT7SAOFHFNNnSxMsRSUDyXxQU01tTgBQyO84oDrdGqbLU+5uczmVa4o
         8m8bDSZI1C7lKEQcrM1iqN+17b4btRNn7ZPxE0R45yxROnES81527GjivSLhF/Tp5vei
         KLuPuhn5iiaHymNEkbJpKNg4HRMe9NiHYmjQby52rKGhVzKFHBXe99RkiTQ//CaWWXCa
         PcdA==
X-Gm-Message-State: AHQUAuaMIZn63ipqtuAlsyLAZxZTootfVdyqioM/OjgiOaze2nX0qWoZ
        zV1f9/p9wSAnMFjGKvTb+nkQ+g==
X-Google-Smtp-Source: AHgI3IZDBcTVVlvIfuujHAGqZHKZg3r3QAddmcYo9jdq4fUaC0ZNKn0cVUCFD+Zns6M1D2kRhWvW7A==
X-Received: by 2002:a1c:19c2:: with SMTP id 185mr310657wmz.8.1549396368846;
        Tue, 05 Feb 2019 11:52:48 -0800 (PST)
Received: from [192.168.0.107] (79-100-158-105.ip.btc-net.bg. [79.100.158.105])
        by smtp.gmail.com with ESMTPSA id y139sm15769236wmd.22.2019.02.05.11.52.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 11:52:48 -0800 (PST)
Subject: Re: [PATCH] ipmr: ip6mr: Create new sockopt to clear mfc cache only
To:     Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roopa Prabhu <roopa@cumulusnetworks.com>
References: <20190205025800.17185-1-callum.sinclair@alliedtelesis.co.nz>
 <20190205025800.17185-2-callum.sinclair@alliedtelesis.co.nz>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <c2cbf8be-546b-f6c7-0328-d638c39c1b67@cumulusnetworks.com>
Date:   Tue, 5 Feb 2019 21:52:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205025800.17185-2-callum.sinclair@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2019 04:58, Callum Sinclair wrote:
> Currently the only way to clear the mfc cache was to delete the entries
> one by one using the MRT_DEL_MFC socket option or to destroy and
> recreate the socket.
> 
> Create a new socket option which will clear the multicast forwarding
> cache on the socket without destroying the socket.
> 
> Signed-off-by: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
> ---
>  include/uapi/linux/mroute.h  |  3 ++-
>  include/uapi/linux/mroute6.h |  3 ++-
>  net/ipv4/ipmr.c              | 40 +++++++++++++++++++++----------
>  net/ipv6/ip6mr.c             | 46 +++++++++++++++++++++++-------------
>  4 files changed, 61 insertions(+), 31 deletions(-)
> 

Hi,
Why don't you do it per-table ? That is - use the selected table and flush
only its entries, I think that would be more useful. Also would be nice to
make the interface flush optional, e.g. depending on a user-supplied value.
Some people would like to flush only the MFC entries without deleting the
devices. Since it's called DEL_MFC_ALL, I'd expect this call to act only
on the MFC entries and not the device list, but it also flushes that.
I'd rename it to MRT_FLUSH with an argument which chooses to flush MFCs +
VIFs based on flags (so you could flush either one separately).

Thanks,
 Nik

> diff --git a/include/uapi/linux/mroute.h b/include/uapi/linux/mroute.h
> index 5d37a9ccce63..8a0beb885cd9 100644
> --- a/include/uapi/linux/mroute.h
> +++ b/include/uapi/linux/mroute.h
> @@ -28,7 +28,8 @@
>  #define MRT_TABLE	(MRT_BASE+9)	/* Specify mroute table ID		*/
>  #define MRT_ADD_MFC_PROXY	(MRT_BASE+10)	/* Add a (*,*|G) mfc entry	*/
>  #define MRT_DEL_MFC_PROXY	(MRT_BASE+11)	/* Del a (*,*|G) mfc entry	*/
> -#define MRT_MAX		(MRT_BASE+11)
> +#define MRT_DEL_MFC_ALL		(MRT_BASE+12)	/* Del all multicast entries	*/
> +#define MRT_MAX		(MRT_BASE+12)
>  
>  #define SIOCGETVIFCNT	SIOCPROTOPRIVATE	/* IP protocol privates */
>  #define SIOCGETSGCNT	(SIOCPROTOPRIVATE+1)
> diff --git a/include/uapi/linux/mroute6.h b/include/uapi/linux/mroute6.h
> index 9999cc006390..7def70cdf571 100644
> --- a/include/uapi/linux/mroute6.h
> +++ b/include/uapi/linux/mroute6.h
> @@ -31,7 +31,8 @@
>  #define MRT6_TABLE	(MRT6_BASE+9)	/* Specify mroute table ID		*/
>  #define MRT6_ADD_MFC_PROXY	(MRT6_BASE+10)	/* Add a (*,*|G) mfc entry	*/
>  #define MRT6_DEL_MFC_PROXY	(MRT6_BASE+11)	/* Del a (*,*|G) mfc entry	*/
> -#define MRT6_MAX	(MRT6_BASE+11)
> +#define MRT6_DEL_MFC_ALL	(MRT6_BASE+12)	/* Del all multicast entries	*/
> +#define MRT6_MAX	(MRT6_BASE+12)
>  
>  #define SIOCGETMIFCNT_IN6	SIOCPROTOPRIVATE	/* IP protocol privates */
>  #define SIOCGETSGCNT_IN6	(SIOCPROTOPRIVATE+1)
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index ddbf8c9a1abb..ccfeebd38e1a 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1298,22 +1298,12 @@ static int ipmr_mfc_add(struct net *net, struct mr_table *mrt,
>  	return 0;
>  }
>  
> -/* Close the multicast socket, and clear the vif tables etc */
> -static void mroute_clean_tables(struct mr_table *mrt, bool all)
> +/* Clear the vif tables */
> +static void mroute_clean_cache(struct mr_table *mrt, bool all)
>  {
>  	struct net *net = read_pnet(&mrt->net);
> -	struct mr_mfc *c, *tmp;
>  	struct mfc_cache *cache;
> -	LIST_HEAD(list);
> -	int i;
> -
> -	/* Shut down all active vif entries */
> -	for (i = 0; i < mrt->maxvif; i++) {
> -		if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
> -			continue;
> -		vif_delete(mrt, i, 0, &list);
> -	}
> -	unregister_netdevice_many(&list);
> +	struct mr_mfc *c, *tmp;
>  
>  	/* Wipe the cache */
>  	list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
> @@ -1340,6 +1330,23 @@ static void mroute_clean_tables(struct mr_table *mrt, bool all)
>  	}
>  }
>  
> +/* Close the multicast socket, and clear the vif tables etc */
> +static void mroute_clean_tables(struct mr_table *mrt, bool all)
> +{
> +	LIST_HEAD(list);
> +	int i;
> +
> +	/* Shut down all active vif entries */
> +	for (i = 0; i < mrt->maxvif; i++) {
> +		if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
> +			continue;
> +		vif_delete(mrt, i, 0, &list);
> +	}
> +	unregister_netdevice_many(&list);
> +
> +	mroute_clean_cache(mrt, all);
> +}
> +
>  /* called from ip_ra_control(), before an RCU grace period,
>   * we dont need to call synchronize_rcu() here
>   */
> @@ -1482,6 +1489,13 @@ int ip_mroute_setsockopt(struct sock *sk, int optname, char __user *optval,
>  					   sk == rtnl_dereference(mrt->mroute_sk),
>  					   parent);
>  		break;
> +	case MRT_DEL_MFC_ALL:
> +		rtnl_lock();
> +		ipmr_for_each_table(mrt, net) {
> +			mroute_clean_cache(mrt, true);
> +		}
> +		rtnl_unlock();
> +		break;
>  	/* Control PIM assert. */
>  	case MRT_ASSERT:
>  		if (optlen != sizeof(val)) {
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index 30337b38274b..0168420d217b 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -1492,25 +1492,11 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
>  	return 0;
>  }
>  
> -/*
> - *	Close the multicast socket, and clear the vif tables etc
> - */
> -
> -static void mroute_clean_tables(struct mr_table *mrt, bool all)
> +/* Clear the vif tables */
> +static void mroute_clean_cache(struct mr_table *mrt, bool all)
>  {
>  	struct mr_mfc *c, *tmp;
> -	LIST_HEAD(list);
> -	int i;
> -
> -	/* Shut down all active vif entries */
> -	for (i = 0; i < mrt->maxvif; i++) {
> -		if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
> -			continue;
> -		mif6_delete(mrt, i, 0, &list);
> -	}
> -	unregister_netdevice_many(&list);
>  
> -	/* Wipe the cache */
>  	list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
>  		if (!all && (c->mfc_flags & MFC_STATIC))
>  			continue;
> @@ -1536,6 +1522,27 @@ static void mroute_clean_tables(struct mr_table *mrt, bool all)
>  	}
>  }
>  
> +/*
> + *	Close the multicast socket, and clear the vif tables etc
> + */
> +
> +static void mroute_clean_tables(struct mr_table *mrt, bool all)
> +{
> +	LIST_HEAD(list);
> +	int i;
> +
> +	/* Shut down all active vif entries */
> +	for (i = 0; i < mrt->maxvif; i++) {
> +		if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
> +			continue;
> +		mif6_delete(mrt, i, 0, &list);
> +	}
> +	unregister_netdevice_many(&list);
> +
> +	/* Wipe the cache */
> +	mroute_clean_cache(mrt, all);
> +}
> +
>  static int ip6mr_sk_init(struct mr_table *mrt, struct sock *sk)
>  {
>  	int err = 0;
> @@ -1703,6 +1710,13 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, char __user *optval, uns
>  					    parent);
>  		rtnl_unlock();
>  		return ret;
> +	case MRT6_DEL_MFC_ALL:
> +		rtnl_lock();
> +		ip6mr_for_each_table(mrt, net) {
> +			mroute_clean_cache(mrt, true);
> +		}
> +		rtnl_unlock();
> +		return 0;
>  
>  	/*
>  	 *	Control PIM assert (to activate pim will activate assert)
> 

