Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeENIt1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:49:27 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5927 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751515AbeENItZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:49:25 -0400
From: liuqifa <liuqifa@huawei.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dsahern@gmail.com" <dsahern@gmail.com>,
        "maheshb@google.com" <maheshb@google.com>,
        "weiyongjun (A)" <weiyongjun1@huawei.com>,
        maowenan <maowenan@huawei.com>, Dingtianhong <dingtianhong@huawei.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGlwdmxhbjogZmx1c2ggYXJwIHRhYmxlIHdoZW4g?=
 =?utf-8?Q?mac_address_changed?=
Thread-Topic: [PATCH] ipvlan: flush arp table when mac address changed
Thread-Index: AQHT6eCDonSu3DsFuku16amURD7SdaQuU5KAgACYnLA=
Date: Mon, 14 May 2018 08:49:07 +0000
Message-ID: <17EB61BE5174F5429F67504099B599AFB9C395@DGGEMM501-MBX.china.huawei.com>
References: <20180512110037.9116-1-liuqifa@huawei.com>
 <1526283581.4411.2.camel@redhat.com>
In-Reply-To: <1526283581.4411.2.camel@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.68.80]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4E8nWKu012359

Hi,
> 
> Hi,
> 
> On Sat, 2018-05-12 at 19:00 +0800, liuqifa@huawei.com wrote:
> > From: Keefe Liu <liuqifa@huawei.com>
> >
> > When master device's mac has been changed, the commit <32c10bbfe914>
> > "ipvlan: always use the current L2 addr of the master" makes the
> > IPVlan devices's mac changed also, but it doesn't flush the IPVlan's
> > arp table.
> >
> > Signed-off-by: Keefe Liu <liuqifa@huawei.com>
> > ---
> >  drivers/net/ipvlan/ipvlan_main.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ipvlan/ipvlan_main.c
> > b/drivers/net/ipvlan/ipvlan_main.c
> > index 450eec2..a1edfe1 100644
> > --- a/drivers/net/ipvlan/ipvlan_main.c
> > +++ b/drivers/net/ipvlan/ipvlan_main.c
> > @@ -7,6 +7,8 @@
> >   *
> >   */
> >
> > +#include <net/neighbour.h>
> > +#include <net/arp.h>
> >  #include "ipvlan.h"
> >
> >  static unsigned int ipvlan_netid __read_mostly; @@ -792,8 +794,10 @@
> > static int ipvlan_device_event(struct notifier_block *unused,
> >  		break;
> >
> >  	case NETDEV_CHANGEADDR:
> > -		list_for_each_entry(ipvlan, &port->ipvlans, pnode)
> > +		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
> >  			ether_addr_copy(ipvlan->dev->dev_addr, dev-
> >dev_addr);
> > +			neigh_changeaddr(&arp_tbl, ipvlan->dev);
> > +		}
> 
> Why don't using:
> 
>  call_netdevice_notifiers(NETDEV_CHANGEADDR, ipvlan->dev);
> 
> instead?
> 
> that is what other stacked device - bridge and vlans - are currently doing in
> the same scenario.
> 
> Thanks,
> 
> Paolo
>
Yes, I agre with you, this is a better solution.

Thanks

Keefe
