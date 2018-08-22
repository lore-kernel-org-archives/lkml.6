Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7C6C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63912098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SpzG4ZmK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="juJyA14N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63912098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeHVWGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:06:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41850 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727602AbeHVWGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:06:11 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w7MIe3Yj005629;
        Wed, 22 Aug 2018 11:40:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=hpb8Bh5wTH2Qo1e53yEWkRUBOgzyQw/HLQL97t2ueL4=;
 b=SpzG4ZmK+9zxL6FgfgkqX/2IjPfIACX4DIhAR7JOHlirJroBwogYNoAO4KYl3oNCU6pI
 BdTyQTRpfpaZi9EM34UT8PKnnyHblfjKAR718/BGTND9GUlENIezrRu7QyZY8S2UnGDe
 ak4WAgFMALjroRz8rSQopyuPx7b7LIx2XQU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2m1c0a0dqp-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 22 Aug 2018 11:39:59 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 22 Aug 2018 14:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpb8Bh5wTH2Qo1e53yEWkRUBOgzyQw/HLQL97t2ueL4=;
 b=juJyA14NSqMRz+sN11FMAVebURL15brQkn3zJVMtZ+shK87uDFcWP/hDQFcYZtKPy8Dh+m3C9MV8o7br/xxLBYzAG5mltUjslVSdDCGAX/Peh/AfGW9MLyNXb1VWxzegfeXqA0nwTpaOHoFWqdi1b6JZt0A3xrPfciFMCd6Z+fE=
Received: from localhost (2620:10d:c090:200::7:dc4) by
 BN6PR15MB1123.namprd15.prod.outlook.com (2603:10b6:404:e6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.24; Wed, 22 Aug 2018 18:38:56 +0000
Date:   Wed, 22 Aug 2018 11:38:52 -0700
From:   Dave Watson <davejwatson@fb.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     Doron Roberts-Kedes <doronrk@fb.com>,
        Tom Herbert <tom@quantonium.net>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strparser: remove any offset before parsing messages
Message-ID: <20180822183852.jnwlxnz54gbbf6po@davejwatson-mba.dhcp.thefacebook.com>
References: <1533854411-28184-1-git-send-email-asmadeus@codewreck.org>
 <1534855906-22870-1-git-send-email-asmadeus@codewreck.org>
 <20180821145321.GA44710@doronrk-mbp>
 <20180821193655.GA15354@nautica>
 <20180821211504.GA76892@doronrk-mbp.dhcp.thefacebook.com>
 <20180821225113.GA6515@nautica>
 <20180821233549.GA96607@doronrk-mbp.dhcp.thefacebook.com>
 <20180822004647.GA10656@nautica>
 <20180822023308.GA5970@doronrk-mbp.dhcp.thefacebook.com>
 <20180822054707.GA13455@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180822054707.GA13455@nautica>
User-Agent: NeoMutt/20180716
X-Originating-IP: [2620:10d:c090:200::7:dc4]
X-ClientProxiedBy: MWHPR18CA0042.namprd18.prod.outlook.com
 (2603:10b6:320:31::28) To BN6PR15MB1123.namprd15.prod.outlook.com
 (2603:10b6:404:e6::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55003cb6-c59c-4347-de54-08d6085e8481
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1123;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1123;3:APsH2lMs8cwUz8bZP/+Bna6ErvT6Ywtu0V3sQmsXxnysYZ1A30Yt5Z8il68fHNrlIeARMfJ7LF2EeR0Wco6hrMA6jA5Zx/CkvT+pVt67Dp8UBnrgLfAL+kgkuyl9cxSLZ2bJE7qVYFCVJgDkAvn1KrmDzr0VqrT1zLpzsK+NJpf5bvcP/t/tOLjnaVpy+bujV34uLkVA3M78to8Z1GkH8uWXcsvdT6RtxLZzWn/Kiz9moQYw+JH+AykTnP+zn3/O;25:SoCye1wHSSFI5PGAfuoQiAC0wl+hTQjjcjhyFmpqLm+emdDsSOzDbM6TLoog4xCbzpSsCPWCkhSwmhFVoVy4YAzytSZXutgJbeSrYOgUhSIbEFWhqRVX1wn1JDh+0jebSrFWWZi0W2vpeNH9tU0kFCevsePmrsQIPJznSv3MepOcz7tcBGzV1dJ7TAySoPVCJ11a+2flcmqMlIGV0R8vRNlmA8b0R38CfUiK4zAXZhteC9azxwJxuiVF3n6sSNmGhRgpXPBJofOHLzYhiPPYgGVJm+FJC4pEsWzR3WopwdwyDpJscf89mpTql8KH9BeXJBeZDVNw3CItLkmU3uhthQ==;31:oZfko1EXOyIdxxTAErZfeJs2yF7WLiAKdbWv6YC64NAr3xzEh8YOT4OeLwSz3Ge7nN2I8oJnTkhj6cPTnO9ESKX0aaSm57l8Ws0+qWBMSGu8MSdArEoqa56BmILPjDa/nDUf4w6jqjFfzuMh1f+D+pzgtcE6OC3DYrF532IYZckrhd30SDuTSYeT+lAKdn0X9uAl6TqWC4DLFmq4I5pXKRV1h9mNUe2cim+Ei0/ak8w=
X-MS-TrafficTypeDiagnostic: BN6PR15MB1123:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1123;20:s12CxJ+77Y/uxp1uPhVBrkZn7vjhLDsi3W69rzFibKlSFJIWOc3J3HusoyoxSClJ/27LcazSHMXQ80xfaT2yKZKzntAsQiIS6Hf4jJDQm66fTjv0hZGy5mpApUaBv83nQXmxb/gRclYUnCH+VFL6IPLL0LTBelLSN9e4uen2xjM10UI5tlVuKqS20uwXfP8CSuqe258SG1CVQZEWG+ZcGmp9wgsDMbikr0Bj1aNjQClgWOyvH+4DXqovJcVVbhXTXAb9Hvycv/g+bE02M5KPZ/w4HkQzZBT8YPQvIyHPiWVTjwlkJp2QWYYNBxfRDRpImcVemJcqhmEP5IJU3uk2DqVHGYVSDiqmzt28HUdw5FjC0/AIqrQkQ+QIfCCmfHGhjjoeC5AEjYU1seogfK2iGeYTzkhTOIjg4/IM/+ljYSMkVPvNkMqwHC2TLPGGNw39V03G97KlAsYIyPtbEonIXrhjXLgAx7FeYYkjDs36eplnA04Nr/3g4fiHvnZ+9M9B;4:msyjPJdVhp034OtaywxLklE/0Zb5KT53i+la02gek1JEWKjJjwqvc0VdunyYwyl1bvJeyCdMz3giKC7MQmk3Sq6SPwGH5chUgZbpUZSvPYjx+zSHEWre0PffqSSNHhiFYgQHM7tUrQ/YfzHWZ4HulQl1MKIVS83jLU90cwwyukw3WXSLRpg0NLqFL3lOaSDN7ZYjcX5b1/v1nZVrQdqr0dXmoFC3oSLz+n6SLbyOccPAVDeTRVbJqVogqf9fcLn4my3qV7XE9P8b+PheIwX/7w==
X-Microsoft-Antispam-PRVS: <BN6PR15MB11237751E532C03551B0879BDD300@BN6PR15MB1123.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:BN6PR15MB1123;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1123;
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(8936002)(6916009)(97736004)(23726003)(6496006)(58126008)(33896004)(6116002)(316002)(16586007)(47776003)(93886005)(76176011)(305945005)(1076002)(68736007)(52116002)(54906003)(52396003)(6666003)(386003)(76506005)(186003)(478600001)(16526019)(53546011)(50466002)(5660300001)(25786009)(46003)(6246003)(476003)(7736002)(446003)(486006)(11346002)(6486002)(8676002)(105586002)(229853002)(2906002)(53936002)(106356001)(81156014)(9686003)(4326008)(81166006)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1123;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR15MB1123;23:vGrsVmIJ96JDWG/FCUWpnFDStkH1Vy2e2SBDyn7f+?=
 =?us-ascii?Q?swvoNWK5PwG+aNARnRYDwLJSsdPsC44/ogF7m8PVb+PUr040+xJtWPuxYLAC?=
 =?us-ascii?Q?5FnyV/oC30N+rkz7mD/4WoTr33DymKWeMQ6OLxJusv9M05W/FwE9vtptjUB3?=
 =?us-ascii?Q?zNDc14YknUJL7KeGHO+gE8SZAbHMlhjFbzjyX/Ndtp2ccmIrtFCQICIluVhw?=
 =?us-ascii?Q?2CWn1jUfK7GTfuSM/pMmZs2GxeGsrA7ug7Y73VlTrZQJEsziuqFyKz8WQsT3?=
 =?us-ascii?Q?+amP+m8HvBfA6xpx8/VZbwFl5E/TuofHVenILwOMwx9oeqKnCHfTArdb26GV?=
 =?us-ascii?Q?E8k3zeUtZSrDbH2ZpOb1QfWUIQIgIpYlLVacgIum2uV91NTqrj6+Pq79CMUc?=
 =?us-ascii?Q?znwhLpcfb3yIlh7upNr4wQUwoW0+w29K4qQswwMVnooRAIu84+htXRVq5uDF?=
 =?us-ascii?Q?kKrM9F3UaBqyrkr6hnt8JeJqAaFfKaxOXY47Qh2F+/gHCSlHo5k4OIyKV82Y?=
 =?us-ascii?Q?YwLatDgsxiJETeceeu6WEbRTiunLSAW8TIya8dMMV9PR8uH69PCIKcomF7WW?=
 =?us-ascii?Q?O9ctwuTbafr0UIlah8opfp1IUdiwHJiFbp15XTkrF6ZLt27qnOONa+/olqfG?=
 =?us-ascii?Q?fu/TpPyt4fKJseJDoNT90cksOIqavr3Bv/hi5BIzsyb2hGB1K78AEUOLVqin?=
 =?us-ascii?Q?ol8ZcFA/Lca7Vr09Om24YgD4cIuIuGCD7/3S0o+FhqkL7HKsqvISZ/jaNTxU?=
 =?us-ascii?Q?5/XouK5v3UZi2zITVwNPhJMvcBWwv15GsToTbq34eaBwrh5jN5f4PKliWrS4?=
 =?us-ascii?Q?gRCKOpjFqtdWzGjlrV4D7pvDTCcSBRS5T5S+9Px2cpTBtSpU0c336XYRzhYB?=
 =?us-ascii?Q?d1Elk7DnXu2lMI7qVbTupfX/GEMUEKckwovp5YGom3uYDIgFhrEZmGSUpNsV?=
 =?us-ascii?Q?baXT+6KL0iNmvMoZ3mUDHPTWyD5MjDk5s/LUvIjFFWxCuKZGfBsrpPh3UBBt?=
 =?us-ascii?Q?qMWYpC55CEpTdDXj2GE/z72j5ncyxLiazOev6cNI8Dx0rVCP++0zi2wTaZHA?=
 =?us-ascii?Q?RBTXn1X7VJlyEaWkpPu/Iq/aua1io+k9XfoxwSybtrTM+pBEgKlDOW/idUsr?=
 =?us-ascii?Q?Qlwh9a4KNr2VTx+Tr5fIyL9HiL8JQM8fNdpOex5/x/hXtU0m/lCNSCm40C20?=
 =?us-ascii?Q?F/1Cgp9VmvIX/QZ/Nivj7fY78jE6hUWH4oj7Mfq6c+P0Sv3ISfGO4pWe3Yu0?=
 =?us-ascii?Q?TncFwxsYm7M/OdF8To=3D?=
X-Microsoft-Antispam-Message-Info: zbCZI5PWHCVqDoG3fDLFwiihYRFYDcCavrOFE5vwgCBs3/EK3HC7E7ByfPX2d7gljD1AlyqPF9rzWgH4bCaZqtK8Tydajg0gk22fmXc8FfeSCxK/k2IBRDkM/vo4rtIK1mHSCBuQwwz+9tZ4q8QVSeAPk999rkDjcRvzsN4oWpiG+aPgiRjEyYAi4VbzqtC4r0KIDuTw+SnkwUTIWnqBFBJXR+K4SIefumWgRfmuOeAcBee8vb3kXIUdq4C6bo0OWdeQruShuXiUI0di+5KhKb92sJxjR4amTP/bdWz7Oa/+pzW5SZF/XWa6exk7WvMaZPjIOPbJfqVFhjVaJVNtJHJ/4WbErN90ui600OkP8Oo=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1123;6:fktHBXjtyMeOn2QtPYqeTa73PUIai1JXMtu81nc4Ij7QEa8n2d8JNq8Yj4v4geyZIR+yxwRe/INUdybmvrWu56GxN6D/Ho7wdoH42QDuAd1yaf8lpPiPEXl73ToX3zUGkLC/5lj+IhJAs1Rdc9UH3tl67NlR61mmCRXO0lVTWAUJ2bHvd6gYwYTWV7dVP+zIyjDn91NlskE8eFH8bgpKQRuGGUczc9Gr+6OPm+Likl5O23IN9JbQc3UU2+ChpAaLAIqiOtEcvVmWm+DWKubhCLCT6dsYacrtSGGnYsOIt+60GvMnMqxOz7C4RkhyKOILHqE28lCpgaUXoqOuqOeF4d6VYGiVl1+pcL4tsextl3+pmTjA8GkoOSjxj+oafJrtTrq6VL8rCHC3c1+YWi3MRnccigW+jNfMBu9wlXInA4Oa9ttkceLQK6Ghfk1++xIzMk62NaFkO/5rDo9MDz4gEQ==;5:UfO8N0K5MHVggtFbzqMPJALyacQlRvftTiRrFSs/bOP7E+V1NeWjgchvPg2eCks4i08rDCiSCSkxoS391rrw1FneQTEDN5j0zjBvWv0xM5dN6WBZbrc9YSgfwwphFHUf5yB/VIZpuoGArX44L9peAlQH2IQKoiHdDKczGA5X8fA=;7:pFhYmVUMF+uSofH/A/JVmzizKlhn9XznXipZU3gqXGVtOfR1pzzgSbXUcraFJ9QU4dSwtHN5qVpfheVd4afMRCvnVEIvF3PvVvkgmI99duEmtGPjpnqtmOar7sxnTTs2cccnSfGFXazrczF3vO0LVX0RWLIU0jgztuDKf92bSBEDvr7+yPQNxUc8PljIHt2QCy+aCdhSoPVkTORa8uUIkDCe9iDw3t2E40TqWROWGJnwEVFdnSnHNbcGqSBQvhPt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1123;20:5E+wZ1d90SwALEWar+j9v+v4yQugxZhf02i9/QEZY8HaLjca/iY4171SVOlon8G25OmORvWlpUtxObspZRdXvGxW007wBCvAF57DVyDj/u5mNMHTuIG28sFaqHPoz2d+q1HEKp77bJuWKe+3Fmqw0mbsfQ8svQ6tIxSNp1v96AI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 18:38:56.0524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55003cb6-c59c-4347-de54-08d6085e8481
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1123
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/18 07:47 AM, Dominique Martinet wrote:
> > > As I wrote above, I think it should not be possible, so we're not
> > > even talking about a small percentage here.
> > > The reason I didn't use skb_pull (the head-only variant) is that I'd
> > > rather have the overhead than a BUG() if I'm wrong on this...
> > 
> > A printk in that section when (orig_offset + eaten > skb_headlen(head)) 
> > confirms that this case is not uncommon or impossible. Would have to do
> > more work to see how many hundreds of times per second, but it is not a
> > philosophical concern.
> 
> Hmm, right, it does happen if I force two bigger packets in a single
> write() on my reproducer; I guess my workload didn't exhibit that
> behaviour with a 9p client...
> 
> I've tried measuring that overhead as well by writing a more complex bpf
> program that would fetch the offset in the skb but for some reason I'm
> reading a 0 offset when it's not zero... well, not like there's much
> choice for this at this point anyway; I don't think we'll do this
> without pull, I'll put that on background.

For what it is worth we checked the offset in bpf, something
along the lines of
	  
struct kcm_rx_msg {   int full_len;  int offset;};
static inline struct kcm_rx_msg *kcm_rx_msg(struct __sk_buff *skb)
      { return (struct kcm_rx_msg *)skb->cb;}

int decode_framing(struct __sk_buff *skb)
{ return load_word(skb, kcm_rx_msg(skb)->offset);}

Although it did puzzle me for a while figuring that out when I ran in
to it.
