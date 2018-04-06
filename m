Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbeDFKdc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 06:33:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42978 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751846AbeDFKd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 06:33:29 -0400
Date: Fri, 6 Apr 2018 11:32:56 +0100
From: Roman Gushchin <guro@fb.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Al Viro <viro@ZenIV.linux.org.uk>, <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH 3/3] dcache: account external names as indirectly
 reclaimable memory
Message-ID: <20180406103250.GA3717@castle>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-5-guro@fb.com>
 <20180312211742.GR30522@ZenIV.linux.org.uk>
 <20180312223632.GA6124@castle>
 <20180313004532.GU30522@ZenIV.linux.org.uk>
 <20180405151123.df20d12168d8a38f7a6b02b5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180405151123.df20d12168d8a38f7a6b02b5@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:180::1:20dc]
X-ClientProxiedBy: HE1PR09CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::27) To BL2PR15MB1074.namprd15.prod.outlook.com
 (2603:10b6:201:17::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 445420f5-87b5-47a0-5469-08d59ba9cc71
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1074;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;3:41LU01q179FHZMAnOqkphW1LF9pc1RZy7Mh/1+gipo25opVefH2N7rBohFTrBsADcfhy439Ja3OtSdePhJzD8To/OfnSo2pXrdaLzNE2cqkr9Hn92AU8CrcUGysEkFN28wITnrgTHDLSSgpEgf4rFy6Sk+hmDULuOb7dVMHH1RPpTNXRvjpHYbnnIRnZ4D7mpYaRyfxS+HlIpw+WTPzfyspxziODKoB1B/u+1h92xg+zwSdGk+rkOiW71273Gr7l;25:INhkLlVHi5AgOmOwLYPO9pYkMzSc8AKW3h181oSf7pVhPiEVpoyoclDcLoM12V3FiLXtZRfdudHpSmbu2iz3w2amvWscnft/bj76SS3m18yNScTj41aAQqdRBz0jOpiN4eACmFveOa0M10nxvP0DpQQ9Vunumx0O9AW5ihGGHuB0CBVUPGa+OhOT3J+xoyaAi1zgtRNQI4A5jX+KqN6R867ZkzuDSIalOxXnC6PlzMpP1jqQsCE9eJtbl/4Ie6Q3nuwQAqTNHO4h9s2RLFQ/LfvRJdcZr0su8wxJiwa/knCFD+jF8f2gB6avrUT5S/pESCjLHyte+cpnEPoPolJP+Q==;31:51cCS9jI1DKMFCsCndDduwo/RRlG4mTNRhI5P5G71ma99GC1odt5CF1Am0HsLzbidm2VZ0plxWTdOIkvnTovyh8/2M3yqczfgSDtex5Se/r0ajj45GrblNzLnKIPjTHqLGBYLM53ue+2Kdpe5tJp/PPi8IpOre3NcGjkt0jPRAG9BKyVVdInJXo/QyPhvJuqK1ha3A3lPQcFByKqrpx1xI4VB2qaI1PWK9f/Q62YkbI=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1074:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;20:nqFr+ZoETcGP/E8EbPQVpFErsbdhB1DkLuDfNPPS5+qY1+TU774fXdL0wwHjtc++luEa0kRXwIbSy8DyB9MXXp27bcnYV30jUKN0NDvuC8sfooRQoklw+/3lGGKOWDQlzFQObss/y83kb93++UnaMsJUIAVu/0AOUtyjUns7QNYhauygqvvMnyuQuGAK9s5J14AlnuzLPHxXcDZ7TmL2SFzJmVM2MXJMEAZh7XIH7y28s3fAJYMzDttDie9SI7KlrDQaYAZltpoQNd1oMJvZZBDhsYyVHc83Fa7zRFNoZWAoMWxiZSHtSkWanyIOpiWmcYXnYktqiYTlci8heDat6R2eI3IyQgmOY3kPaRyLLhvJsQN3MakuoBIkyC1m+RFIzKYAJ/mnYs7CCiK4eUIkU6hwaRMwnHUXoSdqPr9dhGjLDPIkyCtTIwBTVArcNNX4JH4QapqivLtFPza20IxZIedsLhSoZ0OJsy1GxA1qsceTHQmue38mizl49Byq04N1;4:MZCw17uURVG/Ax9kOt3doaeZVu9zhP3L70078K1l07EwDl24kn4VQ8rL2vsBLYd6cxeutHNtcMS0tf2tptg/+UHnqo3M/KM8DeVTebOcpsZ6n5TA8P6TIxY0YBwSmYGSlJkodGzMun/8RDyF+cLXqGa1Dk1URO9YPLkrTgYXw5yPaao5sl7SZqTRjgmw7LKVxBhs4F7iWrtNuTPav2VZF1ovfYFGaWHyHimlsAJvxNoHPM0/aE7xI1WTjEpsmOpDfWokEebWgxY3je1NJMV/Pw==
X-Microsoft-Antispam-PRVS: <BL2PR15MB10741039B5E27A91B1240458BEBA0@BL2PR15MB1074.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(11241501184)(944501327)(52105095)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL2PR15MB1074;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1074;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(396003)(376002)(39860400002)(189003)(199004)(54906003)(52396003)(58126008)(53936002)(316002)(6116002)(16586007)(186003)(46003)(16526019)(23726003)(33656002)(7736002)(86362001)(93886005)(486006)(1076002)(15650500001)(47776003)(6496006)(305945005)(106356001)(5660300001)(476003)(81166006)(6246003)(229853002)(8936002)(9686003)(2906002)(11346002)(81156014)(8676002)(97736004)(6666003)(76176011)(68736007)(55016002)(478600001)(33716001)(50466002)(59450400001)(25786009)(33896004)(4326008)(52116002)(6916009)(105586002)(386003)(446003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1074;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1074;23:uaQLQFaZJzYBqijSGdfFwBLzNjKFZ8akYFLaHuoKj?=
 =?us-ascii?Q?eIF8zh58vY8oMY6rY3DAsu+ONx0qUhH3pzkF/edZsTPa5BZ1SSU41rl6sfiR?=
 =?us-ascii?Q?kCqv5+F6662NmOEx4kQ7if+KJLsQ2/C+Jv2+xiQlcC80ynRTBZpSSXRoABNP?=
 =?us-ascii?Q?CoCFQkr0ehouT/AOKds8A1T7EONQ1wJwVhF4nrMkvzeSt4v6VgK2Cpf+j6xt?=
 =?us-ascii?Q?9EveL6W/zVykY9dF1UbsxzW3GvZ5W+mIiAQxnmp1KP9RYAZTTrOgAODeB27n?=
 =?us-ascii?Q?H8cKjNjkpVZX4aKWaBck1QTC3TGLDlRPa7bLnubTvy0GVGBdi541wPSvsX/b?=
 =?us-ascii?Q?mQV5W92R4pu6rXbhMqNpfYtcqgSecCB3erYBW8vD3YSUVsXcr1iUOt0OXz88?=
 =?us-ascii?Q?W35ukvmK6vqQNGvO6F+Wi75Miy6ry93BLQcqb8NtShoaeU+CcyvKoJFSCSYx?=
 =?us-ascii?Q?4D4lji1FRB4BCySbVHeVXB6SYBBQvL4Hw5S6DqQchpyWWV6bInC8+MADvw9o?=
 =?us-ascii?Q?CP3jihfCcg7HrktD/8zjMS9WKDn6pC4eOX+ICZRurUFedRk0jPk/BR9NqnkD?=
 =?us-ascii?Q?8BAvBrDk5UiyeLl+BN24KK77xmMgiN2iXj/9cc9C4hxzPECZPzbE80DxdBQx?=
 =?us-ascii?Q?GKgQkgZ7UphQWmDvIhnyrdnlcnZ4kvjxvSBoJpSgwmK7GEgpRd8eQlGD3OyS?=
 =?us-ascii?Q?dQraQKMIuIuKwZf1sqeBCJ6ArDBCIsYigqgs6tAOi7kqts8mEysoyobhDuu1?=
 =?us-ascii?Q?ueL11P6FBYr2WcFwwjAVWAznBfTeX0Ko98jasXT332rkxMJ7ZdRKnt7/OcF3?=
 =?us-ascii?Q?XVu+JAT4QqlZz8EywliVAInI8K8vN714YYYk4Il87Gqpnvsdn8foZLWbu/uy?=
 =?us-ascii?Q?6SNm7rnP8dfAsQAXTVDNF7q19q5dy0Zmc6lu0HDs//jMUKc1+RkcOQvk7MF5?=
 =?us-ascii?Q?RJYD27+l6P4/Tp+qgXnYxumIGvVJ5UvfqIssXyrB+b2pts1xsoUzFF3jjsjT?=
 =?us-ascii?Q?Iu0y78AdMJ9xVRghfX6rr4ecuVqJSx7QiPrBxEPLE7haKbZv0gp5f/mKri7x?=
 =?us-ascii?Q?NU43vH+/dvhn/xCLNFoVdS1hKvXEv66hB3rYwbIYxoB68RsYJhvnVgX8Rc85?=
 =?us-ascii?Q?BefDqlO3UxH65B/PbnhOShQLfEhekhlqmTT3hUPByLiEEMIUrLKI2A1qnOYK?=
 =?us-ascii?Q?wsPW1eKTUhyJISs72nRtpuVraeFp9IlcyU8CDeZUp39zUskBzT8bCuMZdO68?=
 =?us-ascii?Q?31/1vSUuBdipSvTu2V3YGk+KNGwKRfJ8O0PBKrrUwSYIqsb3Dmsm0nardiHl?=
 =?us-ascii?Q?QnN2vapD16stxP6GLW08LtTE+3/nYxPJIkxf3gjP+wg8M+TR+SikaxGmwh0N?=
 =?us-ascii?Q?xKQnw=3D=3D?=
X-Microsoft-Antispam-Message-Info: UGK21CcLiSG4kf2T5jF5Ne8nwNMmvK+52w6FxzLxQsfvkPRPzkOCuQDvnCl0kgadFCIFzV/omOavmamVTP64HG6RPdTw08pPj9ibpk5I4StLxyJOxUq0T3i5ayzyDz2zeBYeobCAMD7iOkuyucvgOt+X1nI9gjOSnww6vXtLtvdBUb3jkr+iSSE92eitU4kL
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;6:ELo9LHrLR5kvH5z3F8nfWpVPm4WjX8A6H/twa+8BG5GDp8JSLngJGOZei/5k2A6gkocNO/pefHTGZ1OgqjcPtfown3BpTmnOdrn/hbA9he9TUSUv89dOsPmQjRWqnPzIGW8fhdGpG7TbOCxpA60H2ChlVUCcMgPO5HpVWKE0RezrhDoGFJajx28E5Xf2W1orE1sdsnPGqcG+KW47w/+1sYqiXICJ8rh3lNsOuuRLq3h3vZrFcnP7vKhyzFbCsPCM8wRyeYLTVDKZaVrWkfE16+xsDLUmAX7qV6PUHQhoBQnwuQXuscTYZ5BsfPRv14HB+1M0ZOOuligG9h72LJOymW17/Ok1NG6LTjVb9Z8leta0umshEX7pd0V5e7X/ne/T+xKJKFMSfIl4o6U9Hnk75WcKTkar7ONCzBiCq3OiwQinz0B+b+VXf9yQoEa/IwbCpo2Z42241nPp6TgoRDU7Hw==;5:m8INAeOSqJ+i5dBXVedR/xsbRtyp71M+d05QDJwxBdPoqst+D1qP+cjyu08MyLrwkhTLFLILBWlW6rz87Y6mNZepEbvyKF+RT0JJpDDFLf/pq8evofh+isXiaMBk2tUVmLP9fuujNzBsnb1252RKsD/6LSqzqu34q1dGMnz1+DA=;24:9ZmYUGkN2qqCFKXObp7k6xXItywjLvfTyKZy6cnlmcixKLupUTjDcO73f/ZT5gWVpUNn4tXsi/62nHXZyhivlzRjSsnmLwBMzrwUP1CueQ4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1074;7:66vdErMtqR9L9dEAz3tjMgoKpaHIox09EFQLckklhZ5WDOrAG8lG9lWcrqRsyB7UMjiU65/rX9tSTiaWplnlMi3Kv9VpI8VpCscKRwGVe9GRaEmm51ZcgQWWjSAiWcfkFCdDjv9CodoL/q5CbL5Pa6MGKIHlulE+qwTDtEzWRvTfeHz9Z/TgGRlS7anJ3+jFtJOT+QmwEVXDYYNlaHG/kvfeBZv9kktq+XtU3dyWaCV5KP4efUm/iw0QqAEzgCfl;20:vx/0g6ihY26DQWHQZK4UZ0n8vTqNK0YBtsrsPO76YqMc5mO7s5xuDpzftr5jvWus4HmpW912j+RTj+NSmJlrFD93LIa62dsAgA+GK334jm4t80m2I9UvVtY9r4QqEQUXLn7bCkaxsSl7YKPrF30pdsWltJNzo0XSvdZT4aQKV6g=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 10:33:09.9639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445420f5-87b5-47a0-5469-08d59ba9cc71
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1074
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-06_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 03:11:23PM -0700, Andrew Morton wrote:
> On Tue, 13 Mar 2018 00:45:32 +0000 Al Viro <viro@ZenIV.linux.org.uk> wrote:
> 
> > On Mon, Mar 12, 2018 at 10:36:38PM +0000, Roman Gushchin wrote:
> > 
> > > Ah, I see...
> > > 
> > > I think, it's better to account them when we're actually freeing,
> > > otherwise we will have strange path:
> > > (indirectly) reclaimable -> unreclaimable -> free
> > > 
> > > Do you agree?
> > 
> > > +static void __d_free_external_name(struct rcu_head *head)
> > > +{
> > > +	struct external_name *name;
> > > +
> > > +	name = container_of(head, struct external_name, u.head);
> > > +
> > > +	mod_node_page_state(page_pgdat(virt_to_page(name)),
> > > +			    NR_INDIRECTLY_RECLAIMABLE_BYTES,
> > > +			    -ksize(name));
> > > +
> > > +	kfree(name);
> > > +}
> > 
> > Maybe, but then you want to call that from __d_free_external() and from
> > failure path in __d_alloc() as well.  Duplicating something that convoluted
> > and easy to get out of sync is just asking for trouble.
> 
> So.. where are we at with this issue?

I assume that commit 0babe6fe1da3 ("dcache: fix indirectly reclaimable memory accounting")
address the issue.

__d_free_external_name() is now called from all release paths (including __d_free_external())
and is the only place where NR_INDIRECTLY_RECLAIMABLE_BYTES is decremented.

__d_alloc()'s error path is slightly different, because I bump NR_INDIRECTLY_RECLAIMABLE_BYTES
in a very last moment, when it's already clear, that no errors did occur.
So we don't need to increase and decrease the counter back and forth.

Thank you!
