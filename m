Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeCDG4L convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 01:56:11 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:42038 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751793AbeCDG4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 01:56:10 -0500
From: Stefan Chulski <stefanc@marvell.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Yan Markman <ymarkman@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: RE: [PATCH net-next 5/5] net: mvpp2: jumbo frames support
Thread-Topic: [PATCH net-next 5/5] net: mvpp2: jumbo frames support
Thread-Index: AQHTsj18um8XkydR1EKUeFQympSTGqO8/daAgAKiLNA=
Date: Sun, 4 Mar 2018 06:56:02 +0000
Message-ID: <31a2c6c988bd4d5190e1fb3332f3bc35@IL-EXCH01.marvell.com>
References: <20180302154044.25204-1-antoine.tenart@bootlin.com>
        <20180302154044.25204-6-antoine.tenart@bootlin.com>
 <20180302171713.54beaad0@windsurf.lan>
In-Reply-To: <20180302171713.54beaad0@windsurf.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.5.102.207]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-04_03:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=853 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803040089
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  		netdev_err(port->dev, "Invalid pool %d\n", pool);
> >  		return NULL;
> >  	}
> > @@ -4596,11 +4604,24 @@ mvpp2_bm_pool_use(struct mvpp2_port
> *port, int
> > pool, int pkt_size)  static int mvpp2_swf_bm_pool_init(struct
> > mvpp2_port *port)  {
> >  	int rxq;
> > +	enum mvpp2_bm_pool_log_num long_log_pool, short_log_pool;
> > +
> > +	/* If port pkt_size is higher than 1518B:
> > +	 * HW Long pool - SW Jumbo pool, HW Short pool - SW Short pool
> 
> The comment is wrong. In this case, the HW short pool is the SW long pool.

You right. Comment is wrong.

> > +	if (port->pool_long->id == MVPP2_BM_JUMBO && port->id != 0) {
> 
> Again, all over the place we hardcode the fact that Jumbo frames can only be
> used on port 0. I know port 0 is the only one that can do 10G, but are there
> possibly some use cases where you may want Jumbo frame on another port
> ?
> 
> This all really feels very hardcoded to me.
> 

All ports support Jumbo frames.
But only port 0 can do TX HW checksum offload(due to TX FIFO size).

Packet processor 2.2 has only 19KB TX FIFO size.
So in TX FIFO config code assign for Port 0 - 10KB, Port 1 - 3KB and Port 1 - 3KB.

To perform checksum in HW, HW obviously should work in store and forward mode. Store all frame in TX FIFO and then check checksum.
If mtu 1500B, everything fine and all port can do this.

If mtu is 9KB and 9KB frame transmitted, Port 0 still can do HW checksum. But ports 1 and 2 doesn't has enough FIFO for this.
So we cannot offload this feature and SW should perform checksum.

> > +	/* 9704 == 9728 - 20 and rounding to 8 */
> > +	dev->max_mtu = MVPP2_BM_JUMBO_PKT_SIZE;
> 
> Is this correct for all ports ? Shouldn't the maximum MTU be different
> between port 0 (that supports Jumbo frames) and the other ports ?

This is correct for all ports. All ports can support Jumbo frames.

Stefan.
