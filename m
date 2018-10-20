Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADF8C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 19:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA6521532
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 19:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TU2HxXkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA6521532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeJUDeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 23:34:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45232 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeJUDeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 23:34:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9KJFJGc186934;
        Sat, 20 Oct 2018 19:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vx35n2531/MdQTw9awOXhGNhgdkehCgifWKslgBHphs=;
 b=TU2HxXkMvV2Saf4hqX4ViHm/RGBeiv+AP+UpF/e8N+9MJnWAotvpEGZVo1mXeopk72aO
 nro/z6CiIKQqSStJyoMna6SQSdyJVTNYo7e+ehpImYZ2bDPgAVeVCg98nJsb2b4/wawA
 RxZrlnU4QeEyD9Fi72KGc6WFCXnVXIUqcGnj3xAjtlcxSo9Sm+DFoS+JK2p3YyczH2Jn
 yyxl9K+oCS9N6O7He2zVUqNXVqEkJZMdGA4IbURfoD93y/Ni6ZGCcbgXZWmgc9ZGry8e
 x60xrNtaWPJDQTR0BFbFG3Gm97qwikY7N+nd7C4CAFzVacYcDIJnpZPcgWSRH6ngC6fn AQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2n7ustsbck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Oct 2018 19:22:29 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9KJMSI4011025
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Oct 2018 19:22:28 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9KJMPuv019123;
        Sat, 20 Oct 2018 19:22:25 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 20 Oct 2018 12:22:24 -0700
Date:   Sat, 20 Oct 2018 22:22:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     olaf@aepfle.de, sthemmin@microsoft.com,
        Greg KH <gregkh@linuxfoundation.org>, jasowang@redhat.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stable@vger.kernel.org, Michael.H.Kelley@microsoft.com,
        Robo Bot <apw@canonical.com>, devel@linuxdriverproject.org,
        vkuznets@redhat.com, haiyangz@microsoft.com
Subject: Re: [PATCH 3/5] Drivers: hv: kvp: Fix the recent regression caused
 by incorrect clean-up
Message-ID: <20181020192207.a6mne4npklprlyym@mwanda>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
 <20181017031406.773-3-kys@linuxonhyperv.com>
 <20181017050705.GE22447@kroah.com>
 <20181017062255.oiu44y4zuuwilan3@mwanda>
 <CANiq72kQwhOFC5=vaNZW9qpmohot3ATRJVnn95A8eJ2w2xCNMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kQwhOFC5=vaNZW9qpmohot3ATRJVnn95A8eJ2w2xCNMQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9052 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810200181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 04:42:07PM +0200, Miguel Ojeda wrote:
> +On Wed, Oct 17, 2018 at 8:25 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > It's not common at all.  It should be wrapped in a macro and put into
> > compiler.h.
> >
> > But I hope it does become adopted.  It's better than randomly grepping
> > for non-standard comments.
> 
> Using an attribute is indeed better whenever possible. In C++17 it is
> an standard attribute and there have been proposals to include some of
> them for C as well since 2016 at least, e.g. the latest for
> fallthrough at:
> 
>   http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2268.pdf
> 
> I have taken a quick look into supporting it (typing it here to save
> it on the mailing list :-), and we have:
> 
>   * gcc >= 7.1 supports -Wimplicit-fallthrough with
> __attribute__((fallthrough)), the comment syntax and the C++
> [[fallthrough]] syntax.
>   * gcc < 7.1 complains about empty declarations (it does not know
> about attributes for null statements) and also
> -Wdeclaration-after-statement.

I'm not sure I understand about empty decalarations.  The idea is that
we would do:

	case 3:
		frob();
		__fall_through();
	case 4:
		frob();

#if GCC > 7.1
#define __fall_through() __attribute__((fallthrough))
#else
#define __fall_through()
#endif

So long as GCC and static analysis tools understand about the attribute
that's enought to catch the bugs.  No one cares what clang and icc do.
We would just disable the fall through warnings on those until they are
updated to support the fallthrough attribute.

We wouldn't update all the fall through comments until later, but going
forward people could use the __fall_through() macro if they want.

regards,
dan carpenter


