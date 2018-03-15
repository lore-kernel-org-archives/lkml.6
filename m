Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeCOQrc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:47:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35112 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750731AbeCOQra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:47:30 -0400
Date: Thu, 15 Mar 2018 16:46:53 +0000
From: Roman Gushchin <guro@fb.com>
To: David Rientjes <rientjes@google.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [patch -mm] mm, memcg: evaluate root and leaf memcgs fairly on
 oom
Message-ID: <20180315164646.GA1853@castle.DHCP.thefacebook.com>
References: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com>
 <alpine.DEB.2.20.1803131720470.247949@chino.kir.corp.google.com>
 <20180314121700.GA20850@castle.DHCP.thefacebook.com>
 <alpine.DEB.2.20.1803141337110.163553@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1803141337110.163553@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:b057]
X-ClientProxiedBy: HE1PR0301CA0018.eurprd03.prod.outlook.com
 (2603:10a6:3:76::28) To SN2PR15MB1087.namprd15.prod.outlook.com
 (2603:10b6:804:22::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b56b3ec-5cdf-4bfe-f76e-08d58a9466df
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR15MB1087;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;3:Tv/8AtbkR5Gz1QXsFbcvvYSi4iejkVgyw6zuTwUNEVcSjSk28Hz/ljiIw7zlGVCPFsNts00tyO8JAXusVe+OxjGROKjIM7ZPr7Zt4op+IQyUdYo+hxTb6PCJCWPDf5VtQTS5+cu1AHzjLQKTDOFavyRQn1FPmff0rHLGUTO+gwcBJIbGzLO2lurEmx6kP1oqM57svszil2UysiR6OBq9Br8zvLTEqFATxp4TbMQbr5F6kf9uTsc1Hb9WbqMMpxkR;25:UO3idM/UDbWPjS0hBlMq+0ewzGEND8XHoFBc67FlgCx7PXF5ZQUEobvxXAhzdhQADPRu+egP624vRiebVnXEZ5fD63go6w+GGYFP6mS6fZRWiRtGbPggXr1KDdi293sHUUM/51o8dvMIG337VCRt9suGOACoenavFCunDuPyqldic+JSackn7kxAK8Uu2xeWb1kMHCUjWkWaUQNux9dOhKrzYkYzpUhjmuP0rolRxSTCH3gikZ+lV5NChVDnObq6dHTjYWTcqC+fs3m/gWsCrm+etwy/x5XDEpum69nbPcLUp3sW8SEqRytYcEVQO1lIfHI8k6vROdbuc2RuncmGjg==;31:jgm4Ry12uGD3hhTG1cHuvTWsoH36twdFFyKfH27rJR1MiAQxLEWptZ9Bo9UiY1Js+yjGmSeMerMG2ulVtUjP8/PHpIvMJjLR+YKVv+LZoCr6HeQhARC9f+yqKwC2w+mPLoYZ6AHSmDLdEOR5hiRzZ9a+7yT8sLzXn8Iyh0GBDTrlOLU0N7VAinweex9WlCe2kU81ziu2JabU2KXwNo/52+5JFkB1v1Zq6uo8+hKAFNY=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1087:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;20:ku1UM9L3bQNKt5JMt4U2Gx/AjEEV8itTpByVWEznPc24XmHyKy7Wzzs9d8X2MluD1jUZAbMqxdbJ3mBOmxI2rhiTPhRpg7Ve1bk7wOLw31+73kXUa7EvfxpMMJCxyIOR9e6QFOcfYgJcwK5uOMNa/9dBIHr6goRMlDVbi4ba8WlT9dfaWA69P5jhJQgCKgF/XhyZRvJ8dQ1XqfNEXEQx17IuUv+Jci7e/V/eWpy6Ew4wFeBYf63TdnP/nAGRQTCkAbTqwssc9E/5Pd+jNhGIvoJIO5l9y3CNQ4KAhbPqZKHd9Kg8jf72hYpY3ITE8apcHc/HjCLigKkG6Mu4DGroksdaOtTWwEFG07bCRHjcw4TXkTeqo/9LcSTn/UStz8QBvIveVF+vubvmEEyeRmZWgEAaAh6moZmx9QgDRYVIQhbm+xMZ0znT+R+1AzJok4PXMQv4AgILGSrcW0X0A6KJihp0xqesD9VLFJ68mOfD78szGzEUwmxUu3G+4KONKgmO;4:rE0HfwfHkYt9xNcur/+lCUkD0TULRciFTPjy73OhakO/Hi+Sw8Cqe3S/X7KHSZIEmSmMYpKLLN4+GeCWb9KmCngr15pZ9KEO8j1y5chboQrFrbCgpSMO4y2Un/yItShx8TXVhT+0ePZA+Fy0V/4o/EPPKWORHqhBlNGOv4pal5LRG6EVreIXGoR4OWW+tQpqAic2nzp6O4z/IolkdcJpNet0jA5RieE1no8xmclm9tlW6OXgwtWjRDgC1mY7rpIQrgb+jeGsXRFDXCGU5G7mMw==
X-Microsoft-Antispam-PRVS: <SN2PR15MB108754914DE2AFE6A9D9D65ABED00@SN2PR15MB1087.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(11241501184)(944501270)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN2PR15MB1087;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1087;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(199004)(189003)(50466002)(5660300001)(97736004)(25786009)(39060400002)(4326008)(93886005)(6916009)(6666003)(2950100002)(52116002)(386003)(6506007)(52396003)(186003)(7696005)(86362001)(16586007)(8676002)(58126008)(54906003)(81156014)(81166006)(47776003)(46003)(16526019)(76176011)(33656002)(229853002)(316002)(106356001)(7736002)(478600001)(68736007)(8936002)(55016002)(1076002)(2906002)(23726003)(6116002)(9686003)(53936002)(6246003)(105586002)(305945005)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1087;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1087;23:5Pj4rHCq8gq0CQ+w+Kp72l95JCL1A4n7G7L64pgbX?=
 =?us-ascii?Q?z7Sey/OZaLZBR3WnrqpUTiepyfXlTvHKL/7fGHYP9stfggdy/1/Upf7AKcOw?=
 =?us-ascii?Q?6FRxP3JXqHRwzTQp3I54dqYGEeJpNkYNUQXnVPKnlHOhcULv576AHGggxJXk?=
 =?us-ascii?Q?pYHURJTL8szZoueUYTj5XrEpj01xmwk9/ybOkAEXx+h52tUX9/WAivIMRZos?=
 =?us-ascii?Q?Cq2IY2V2EvXG6VI6qvMRQL6f4iJPZYykfVNrsXuwb3ga1PT/9ETKjlen6Peo?=
 =?us-ascii?Q?FLE0LkwOwXgWeu0x5GZtTU0Dsp2crYD8679OUF/aJnGn5NvBx38SdOi5JIYj?=
 =?us-ascii?Q?AdGsoCYJYpj01IZvEWjUTyGh91CT0eg2A6l1h7i+JLPV6aVW3ff3E9bkGovu?=
 =?us-ascii?Q?FXgTcSyhqQao7S4B95sLxY9SX7/wR7yj3Wzvja8ubBLE9T7NKKqoY9FEvHDn?=
 =?us-ascii?Q?nntm/f32l8gFbmg30/6frEIQFqAU2NNH3O5qptNy0DpFixv4j9C0CaJ3KRTC?=
 =?us-ascii?Q?iJtRs2MXCMD7IRxQ8srF7Pm/ZcTS0O2W6Y3xPw9aO6fX2PLE1mXEucwLYjAE?=
 =?us-ascii?Q?VpC1koQibVzu9/c39xwpLeyjX3+HB29+PgWVaSh2xPVqj/oY8oqjZD+KfEi4?=
 =?us-ascii?Q?BeO8fZo5gwnpz6KehlnWffWDsv5J/4Y1iJxqN/PxzZSFGbAQQlLFRGM2EyTm?=
 =?us-ascii?Q?52oTGt+yQbbruz3Jpgn4lC5jio4LVh2yTLmcrrUxaVQL3vpEJsRX8PU/5WE9?=
 =?us-ascii?Q?d+ekq+eEaVPIrvzhjW5IqG0/roNsaGgT5sMsltQjs1KiYA5Q3GeZ0tcas//E?=
 =?us-ascii?Q?xykS9TSWA5G1YdlCjoM2xlsZF2z1lzXTdnQYjXgeDLnavVx6nf8dRV4Sq9Sg?=
 =?us-ascii?Q?inYqh94rHMD4BVpY2Axtsc/43mvLJ3Ad1dwMsgMgqixnbBBndPNr3qlaKHb2?=
 =?us-ascii?Q?q2n+erD57brgY6Jtc5Bly5HRXKXR3Ae/v1TUjrc54eoY3GjMnTxixVfa7ro/?=
 =?us-ascii?Q?0YtAACbDJ3po8rGrMLFMEt/8hBVW08/07+foA6yHUB9wq5Qba+PvMrmkjtmj?=
 =?us-ascii?Q?X6sKDggzYqnmeJ5zQa1PChcC2IUc94trxj7QXVE6Viy6ITKiF8ZgLJBvPikD?=
 =?us-ascii?Q?+lsnbfz9d0xvM18kvUIF7cuWDD1zHIla9sLLalfncvz0OGqlLZjRVyClTUt/?=
 =?us-ascii?Q?6QIlhtcn4NJ3bW9UWeoo3HMyik45eXsyoRRsYLzNeYWvcX7KBVMrh4fqpOl7?=
 =?us-ascii?Q?/eDzSgpO7YTgf4agsQ=3D?=
X-Microsoft-Antispam-Message-Info: ZufeQpUJn6TgMLUyzxSet+bgepXhV24qigT6Y5M82RpBPNhwCHORwpwKzGOojJK2ueoM6bNjOjcs5KfDBawj4Gg22JP1MU06Z6m2arZ22pwipGgKPJ5mgPeNqAHYqCXlMchpDnYdtFkj7m4AdkqpyzzE98/z5opHd0xmAnI/TPiTjhp1knjXq2ukI9x/ChQL
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;6:ZT3DQ/mUt8nwVsPHXixuXoYdGfkExH5iuY287MLJKSIUUtDkS/OtIDJwvvXApcfArP41L3qhOA3B/fgpdPMwd8Edd39nUx6QT3Hurd459VqgGvYegMEfEt/p55K+MTzChJk6FX0JV0vqrgyIB/z9vDDveflW7gFLnr1+foKdDcKnGQJFzqxNGWz+jOyJrIuN1EcpNviDoG7dW9ljYvgfB4rpPtBMW8kSdTmNGHqr1xFTDdnNJCnYFKET9lZT2rX7n+jDrrOXJFS7JPR6WEvf29SfTXMsOljnI38QwuadVXx4S56fk3VsRDhK0+MI+fnI5DDAhf/K/QCqLRoLB0TjmM8bPU8xdLTMpExRKgwjla8=;5:i1bfjTQIsM9QcspUWZO8aQgRgXUgHLNJv+EEYKuPEXmckNY+q5UeFXH+STXwHwU/ezYd3aqK/dbRdO4VkGGxV7q3v3hu0XdPPfWfD4QklsPm99a7f7PFWCxzaZrgzXrEdV2cY16GaPJsmCf6JINF4gTC2+AsJ8fK5lqHYYB899A=;24:7LqOV6y7Ph433jm7+lawAa7Dkj2PxPxbfcRL6I9oaBr9uF11cVEw8GXFU/zIy3GBuxNE//A2RQrKcBlcTc575qHI5+h2g42G65GW8/jd3Z0=;7:l4CBXg4YQJWGFO+0592Ye1LHjyApSMzeiQCREMtd+++l8FdEH79p8zxa5CmOQGSTjN6EHS4tVtmKcejk/OmrGK61sM+Yc+t8hdihRBsCHE8/4W1pV044r6oOOa08zInBcMAllS/vn8jaRZ8Lh4CbFCFGMbXE/p1InE1ifMpyqTgeWqlg8RgVRnJOMUVyc5BTl4+KgKHKGJZF1XMY63/v67uEnZNOWkg1ck3mSXzOwN2GvzOmsian1yn2DGykaRkG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;20:oSRlbR31Ds3YeS6RisxDU2zQjJ4CEsq6zVVbWxyvym0FuflTAKzb/GcqmLcmax6Td2er153XnuofVGSg7IlMwnoB0xag5OUIFe8uKVAzs+G5bQIiKhqIqJ00le65cEvKPBTzAzfGmNYa7zy8OXKlUVgDHFTgKcYYLEfUZDLBBrI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 16:47:10.3070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b56b3ec-5cdf-4bfe-f76e-08d58a9466df
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1087
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 01:41:03PM -0700, David Rientjes wrote:
> On Wed, 14 Mar 2018, Roman Gushchin wrote:
> 
> > > @@ -2618,92 +2620,65 @@ static long memcg_oom_badness(struct mem_cgroup *memcg,
> > >  		if (nodemask && !node_isset(nid, *nodemask))
> > >  			continue;
> > >  
> > > -		points += mem_cgroup_node_nr_lru_pages(memcg, nid,
> > > -				LRU_ALL_ANON | BIT(LRU_UNEVICTABLE));
> > > -
> > >  		pgdat = NODE_DATA(nid);
> > > -		points += lruvec_page_state(mem_cgroup_lruvec(pgdat, memcg),
> > > -					    NR_SLAB_UNRECLAIMABLE);
> > > +		if (is_root_memcg) {
> > > +			points += node_page_state(pgdat, NR_ACTIVE_ANON) +
> > > +				  node_page_state(pgdat, NR_INACTIVE_ANON);
> > > +			points += node_page_state(pgdat, NR_SLAB_UNRECLAIMABLE);
> > > +		} else {
> > > +			points += mem_cgroup_node_nr_lru_pages(memcg, nid,
> > > +							       LRU_ALL_ANON);
> > > +			points += lruvec_page_state(mem_cgroup_lruvec(pgdat, memcg),
> > > +						    NR_SLAB_UNRECLAIMABLE);
> > > +		}
> > >  	}
> > >  
> > > -	points += memcg_page_state(memcg, MEMCG_KERNEL_STACK_KB) /
> > > -		(PAGE_SIZE / 1024);
> > > -	points += memcg_page_state(memcg, MEMCG_SOCK);
> > > -	points += memcg_page_state(memcg, MEMCG_SWAP);
> > > -
> > > +	if (is_root_memcg) {
> > > +		points += global_zone_page_state(NR_KERNEL_STACK_KB) /
> > > +				(PAGE_SIZE / 1024);
> > > +		points += atomic_long_read(&total_sock_pages);
> >                                             ^^^^^^^^^^^^^^^^
> > BTW, where do we change this counter?
> > 
> 
> Seems like it was dropped from the patch somehow.  It is intended to do 
> atomic_long_add(nr_pages) in mem_cgroup_charge_skmem() and 
> atomic_long_add(-nr_pages) mem_cgroup_uncharge_skmem().
> 
> > I also doubt that global atomic variable can work here,
> > we probably need something better scaling.
> > 
> 
> Why do you think an atomic_long_add() is too expensive when we're already 
> disabling irqs and dong try_charge()?

Hard to say without having full code :)
try_charge() is batched, if you'll batch it too, it will probably work.
