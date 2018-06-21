Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2767AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2B72075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LoxcY8qU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="clwnR/7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2B72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932978AbeFUO1d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:27:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47832 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750806AbeFUO1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:27:31 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5LEMN4p017841;
        Thu, 21 Jun 2018 07:27:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=rSGxXqp/eShFz/hxcOB3/zeEvuV/n66ge5gvy//coQQ=;
 b=LoxcY8qUdA/v9P47/nSvMzRpFBGO0cFfZBKBFbnqYHLsnyKxBeIQB+acBlDx4wUxrI/o
 xaJY/XWsPPEf9jGkad9hlXMutisUnACyywoAnsyTeBgDrdXQ8RMwWUsrj6YTEjFvZwTY
 Tk2fTqf5uFMrFQumvw63t+feuCeaT+EPeIU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2jr79190yb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 21 Jun 2018 07:27:07 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 21 Jun 2018 10:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSGxXqp/eShFz/hxcOB3/zeEvuV/n66ge5gvy//coQQ=;
 b=clwnR/7CLbZOQbUb1FzO71alUE1m8kCybKi2uuyeuFvNWkGVTMhWCmaD2A1pdP6OSwN/TSR+4Bdwk3X3z4/XBz07Fv3Q8It52bfxBcS/Xa4dZa9nq/7guyK7dIl1VZEJwDNlkg5sPjJBnMC076JtX7FsEAsmu0wgby9g8iyloeY=
Received: from w1t1fb (2620:10d:c092:200::1:81dd) by
 BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Thu, 21 Jun 2018 14:27:01 +0000
Date:   Thu, 21 Jun 2018 15:26:51 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Quentin Monnet <quentin.monnet@netronome.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 3/3] bpf: btf: json print map dump with btf info
Message-ID: <20180621142649.GC1176@w1t1fb>
References: <20180620203051.223156973@fb.com>
 <20180620203703.208599277@fb.com>
 <86ae5059-54c8-d078-4f6b-b212285dbfec@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86ae5059-54c8-d078-4f6b-b212285dbfec@netronome.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c092:200::1:81dd]
X-ClientProxiedBy: AM0PR07CA0023.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::36) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b0f8c08-b65a-4504-d03f-08d5d7830f1d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2501;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;3:PvZYoYVQnHF6W0Wzr1zPbDWINNgPCIIBsoTqYIiGPG64VeFGu09bqulZJS5JCAlQIXe5Oufv6b4Ughv6ilLM9R4G2oqOlraReuGreMNM9ivyZAWdRJ+A9/gjZC9ZJ3HMGG2kDelxJrBfGdtyJPm4O1Tw7kC6sHWupIYFWVPow2P5cXWw6sIM3SMa7keELdNz6/lTEscUno2/JfOefWNhsFloTK88b/QBELrNBYYaeh+SlIO1ImMhCrUUn7XufGkU;25:uT/7sm+uK68qb+nQ6Fem4dOiM/wHYamCWYbWBesH1PeXuZwo+tI1xJSvGa8PMi/npqoqCsADK/RDI3dUWDIzismOw7f7s3+eTgcb4Zm3Orepd3FMD3p3hwNI5C6z4OaA/G021maV8qvVOHdagEgW9QDEP8GR6v1OgJ/svWPpQT4coI75ePgagNS9+9vxjWFu6knmkKAReIJtGaYbvQX5MDeueU52vYdBGwqvMHYvl9wr1mBJdNvMPc1ULs4TQufR14RTB78tcWqcRSuSSI4OqvU0knCqoI4mnnU8pSZaazlL5OWbNKGE7K0LpKzLT0AmZMBiHJ0eoww9mqaERH4ONA==;31:hdf+gxaiRkoF8xK0GtRsklw+K3rsaXDmIhk7Fyn6EgRnrMMH3QZ1IUirDSqYJJkPEtcqRHbJtwWev9eAKi1N9WhwtfSCPCuWPFTSA6GW3IzV1jkp6okLkD5vZiz4eVR1ivWI8ptzhIYkL+3P8yo4SZTScpNmsCaHMYQV2E1V5wAquglKA4CX1/3/yMVchHn5x2H6GNmscmH0UOgbS66AnX0b6vLWwqgYBbYLxA3y9D0=
X-MS-TrafficTypeDiagnostic: BYAPR15MB2501:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;20:XdF9EvwzBCErmNtaTctBIJN2O4grUqVJ0eNt3W5AM26UBNWAe5uaugbnHSt9O4hwhM6zjiUznov99mrGewFxuLf3+kpF0JyDB1ZaUkjU3b9z3w6WfG1KnFw+/UM01jFJSSVpin8UvepvXAnMNvYH9BMV5kkdTuGsyCD9wVSe33zOnxSOOFBkCXb464pLTaKe5EoOWODVZrTkYSVXIFp1RuQ98qXYQgkIFOUgbz1SLnQKWtUd3aWwe2nEzZJCLgOCxjYdHjfF+JVguizXvGm0wGgt7ZsXgjUfmPFegi4W2Ae5I1U4UfWAmCESUsC+JshCPqC3+BzM1xzPx+Z3tUEdfrxcs0XWBb0k1FfGAwz7V9uFWyeXm4VjdzSD/usbFirpMaYmHGdhzZ3o5O5jnTGYW7gt9Xm42ViZ+Y5V3YRftzA6ZeKv0zWWZXPSDWOFZpzENZJuk7A7nfBjhiqWvNAL+xRd0NiL2qEu5ZLHwR0tOnjnxh08Gexve8YUxktIzTDQ;4:Z8nj3dvtknKh3jmFUAnslAd9rFqF3vDFxllFLIGWbmFjKl5hWV+1rybU5ZIWCqQ27MvSS2jVSnBLlp88Zx/mk3TCRzViimhhB5um9bIMhzChjd2kzvXMBDPHJ27K4ItQoufQafta38asCMHlDwPgr0rsqd5Njps1Joo1tSzxlEAFWZ5c95m+aBfocsRyMXlcDpe+E1NWt50YvM7kdBhKg3sNzF7467TkHA50GqMt5vENiLQPwcuTvZbfOHiQXbvzN4HTkkGUxuiSLcXl6XRJ9lVp/sJ/cIAVEL61xu3ddDfLRza0GlT51wsgPFxx8HF6
X-Microsoft-Antispam-PRVS: <BYAPR15MB2501B5C9F9A901D45CF7A340C6760@BYAPR15MB2501.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR15MB2501;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2501;
X-Forefront-PRVS: 07106EF9B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(39860400002)(396003)(366004)(346002)(51914003)(189003)(199004)(33656002)(16586007)(11346002)(446003)(316002)(476003)(229853002)(54906003)(33896004)(6916009)(59450400001)(76176011)(52116002)(68736007)(52396003)(5660300001)(58126008)(6496006)(486006)(186003)(386003)(16526019)(6666003)(105586002)(33716001)(106356001)(46003)(4326008)(97736004)(6246003)(7736002)(39060400002)(9686003)(8936002)(47776003)(2906002)(6116002)(305945005)(25786009)(53936002)(55016002)(86362001)(50466002)(1076002)(23726003)(81156014)(8676002)(81166006)(478600001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2501;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR15MB2501;23:5n0oeAmDIheXKTFTz9ah1UmNLg2VOIjdKskesYl3H?=
 =?us-ascii?Q?9TzB5tSGvrcYiB6WyuDFzNtcLW76r6L0xrdCksrG/zhuKrYHU9ig9mmKqohK?=
 =?us-ascii?Q?bBTma/p4cu6mN/E5rl9VtwGwGeY5IyooLHmV7Eg3BjuOiOK6zYAVO5s2yN7q?=
 =?us-ascii?Q?7B6sug/doxTK8wR5IEw7gjuKvYR6ZBEHIPxGn2amf/GM14hwEpC69YR1dmzC?=
 =?us-ascii?Q?TmHH74sPqmmA8rGVUwjDKWgyzYLL+DI6FsbakEmikDAiCDueoRmFR+vlj93Q?=
 =?us-ascii?Q?SBDfYkqU/yIy5LvDWh9PmsoZ6LUQFTrtSuUTU3PqlwdNgNgVGrtjr6/28D8+?=
 =?us-ascii?Q?oPERASASPTJVtRJP36nk3IxXmALFrT+boUNtm7D0VI0PU/B14jWV8YYJgb4h?=
 =?us-ascii?Q?S7RWAEf0jOqIZWysz2WJCLRFfP6ESoOxtmSXphOTRTP1sjyP4PU6dMYPKgM3?=
 =?us-ascii?Q?j5HkqO06spR5CTOwWKjDYIBnNOL3b6Rf9Yo6JbzqVavYLQgC29p13J/CHwcr?=
 =?us-ascii?Q?J9VI305EtoI1qMV/A7WD9e2NYjJBfFL5U1spHhd24pVCikz2D4lw2fkHC0Nd?=
 =?us-ascii?Q?XSGIlq3YDCuWxOA8c+UJVJXuRqhluk7sdf396Mcs6QIDeXvUSzAsT6m1m7U8?=
 =?us-ascii?Q?F3G5hrrmCZ+1wT9NRlHSlEq8gEtRDN2si+SiBM3ydG0tqkHNMeC5+WTVnmcI?=
 =?us-ascii?Q?TV1n7Np0WiY4j4lAuFf9ZerotjdCBL1HoY/+1Zj93h0iDS2SsHD3ym6VapUK?=
 =?us-ascii?Q?gSoA+47GKkbP04P9Qfzgjl4RU2btDVJpF78/haoKJ0uZ/iSy/Bt7s5f5Lnb9?=
 =?us-ascii?Q?OGFMnXWI3NPLxaA2Qpq6qT+L9WxDqNEgVn5NoZjWYb6aBmYtdMQH9GjDBSBw?=
 =?us-ascii?Q?bv8TEwrAc2+MXcmaE52ta+aau/FNXSPH0ulOYRAnSX8/Sn/el+1c2drgMPqc?=
 =?us-ascii?Q?TqPxZnzFc3HtDST36/EQzCFadeGTVN+MdYN9Z9N2JVwfZUP2dckUVO7wa0SK?=
 =?us-ascii?Q?do90w4NlwMoqr4E7MsxyrM+FptXYbfXv7rXocsItD9yDNcnxV1iIxkK83BBH?=
 =?us-ascii?Q?xWRaYettSJUI7U2v8WDwT9T44pkW/aUTRquK0Tdv1Z0j53p5i/a0UXHOznI1?=
 =?us-ascii?Q?ASrCp6N2TALVevWxMmTM+UFeWb1Oz5bMbsDRQq8qLkA/n6Z32RgB5qoq3lsa?=
 =?us-ascii?Q?EkXQ8HO25zTkDXbsTOQArjQIuKzKFKpB8MwYK7+HwaCTKVOINYiBZCAvgmAc?=
 =?us-ascii?Q?eGslVzL82kpmzWMo7ayHOY8NW5H2foZhRmiV5UNKphkRwikQDOaRqas9N6aQ?=
 =?us-ascii?Q?h81Uc9h1Rm2p63TKzCaUSialzlUvt1Eb7qWcw7d0wReBKwNgToEXy8e4SvW6?=
 =?us-ascii?Q?L0E8g=3D=3D?=
X-Microsoft-Antispam-Message-Info: sJMZuWgVApOTn9+AY1gnJfBVcK3aSUxXOpo/ypxkex3E2nGIJQESD8XCzcJNLi0+lZ3EjMj8pKKcI0SI3eyllyOA5/FasfIrjN5WSnbfxs+E2+UMLvPr2iW0EFNMbWQ9bzAYlL9jDrPK+lmBhBEVrs032X346okZghCzo6BirtY6oV+V2uCdSB7ZT1sAcn5zUgYUlJ8+ikoIesX6GUOYs4+s4eHaNyH38j1/vy6yf0Xcf2/BLWApSy8NKVWymkEYdq3utP8+c5byJImXH23Z92xu1/zDatzXTMJxUqgj544vg6BuC6ALU+a0C3BBASSC
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;6:e2PdgqgtHgE+sLjWbVY/XGD9H9VdGXmv/NODHjT8yW5tbVovQ85ClIwUJDZmqh5rlih89WnNEKyikxn3Eg9HSapCKILVwYgsZ+cNP5DvzL9mdMUA2EluMcd7vA7dBI9z9QWiZwsPqynq5EkJG3DAcEeQB85+s1FpkoGasFvMjDKbl79vwNpZc0uBGB/Upv0eO3SmUgpWrTdclIcAJG3KRJ/bDiNjVKRh7IJhFiBl1eiNsn08bhBuSXtSvytGzSnQ4aMdnbM+yqSACz1M9kxr9AZSQ8B8Oyav3g9VicEsgvwgJ0i+difdifvuMwNobTHiM3EDcoUy6AkhMh2l36Nfe9z9hKuZPECLlnQLVMpkisDgZSgiA/iGATtnhTjtK/HrvPw/DvVbU0kjKZW2ppzZ7gdXXZnC4KkR43LeXL0AuEa2BpHriymlXC+6CF8YLFKC0BG77xjwzF4onOP80GGKmw==;5:I7islsOVD0MFC47tjucuBbBEonLGi7AI8NfZz+Qq4Q+wtKijemXsGeYTin/ZY4xJTv2zEUqibqil7Ryd4i9q1bhHlY6zNAkYEo7CxsJ7WlHDaxDiaon8VQE2f/2TetW1vNxbXib28S+fmWukm3lv/E1V3LK/YnSc+CCxij7YEME=;24:hr10btLSR8RnswwiBwAKN8YhPC0v9mGSyNiOpqmSEmtyBeM7eZSUqwxqE/+AK+QFPVVNxUl9jGa74WCg8B8jQq1ywu5bCn0L1ZWQ0bE3mWQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;7:Cd8TUfNazR3y9tbo+BO1A8EmO2x8agwBxCgYIbYP/7QcE9iIe91dysmx6ZQ32MzDNzjQZpCpdO6kF75ITu1jzCBPCFf7cMJjEGIwIqQUb4o+Yi5Jo/HiKR68g55hgwD67CeWpC2zISeDbgMfJiRftAlTj4Os5Xyh94JGp7NRylu+CXHA82Y0qS6dNEdMxmSEPxbwl5AZCd7YAtW5wsf693a8Y11kOKHbQ4F1GpV2ZaF/UwtlUPgzLDX4Gpm1AoxY;20:SFoJuZc9qQoFbgwHQgISUUNtZD1pwsslZ6Z28C6lQ8KzWqArVZvgGoj+CmfW74z0SOnxwfcTpOmWj1I+6ZtWw26Flpfw7kUP5zQCdFb+CDKwAd90lom6p6yFo5J2f0V6rdYqLMwXMPPIkT+ahU4rcyAG0xivpLmNGYqIvDj+1Nc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 14:27:01.4586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0f8c08-b65a-4504-d03f-08d5d7830f1d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-21_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Thu, Jun 21, 2018 at 11:24:59AM +0100, Quentin Monnet wrote:
> Hi Okash,
> 
> Thanks for the patch! Please find some nitpicks inline below.
Thanks for your feedback. All of it makes sense so I'll send v2 with
those changes. Couple of responses are inlined below.

> 
> 2018-06-20 13:30 UTC-0700 ~ Okash Khawaja <osk@fb.com>
> > This patch modifies `bpftool map dump [-j|-p] id <map-id>` to json-
> > print and pretty-json-print map dump. It calls btf_dumper introduced in
> > previous patch to accomplish this.
> > 
> > The patch only prints debug info when -j or -p flags are supplied. Then
> > too, if the map has associated btf data loaded. Otherwise the usual
> > debug-less output is printed.
> > 
> > Signed-off-by: Okash Khawaja <osk@fb.com>
> > Acked-by: Martin KaFai Lau <kafai@fb.com>
> > 
> > ---
> >  tools/bpf/bpftool/map.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 91 insertions(+), 3 deletions(-)
> > 
> > --- a/tools/bpf/bpftool/map.c
> > +++ b/tools/bpf/bpftool/map.c
> > @@ -43,9 +43,13 @@
> >  #include <unistd.h>
> >  #include <sys/types.h>
> >  #include <sys/stat.h>
> > +#include <linux/err.h>
> >  
> >  #include <bpf.h>
> >  
> > +#include "json_writer.h"
> > +#include "btf.h"
> > +#include "btf_dumper.h"
> >  #include "main.h"
> >  
> >  static const char * const map_type_name[] = {
> > @@ -508,6 +512,83 @@ static int do_show(int argc, char **argv
> >  	return errno == ENOENT ? 0 : -1;
> >  }
> >  
> > +
> > +static int do_dump_btf(struct btf *btf, struct bpf_map_info *map_info,
> > +		void *key, void *value)
> 
> Nit: Please align the second line on the opening parenthesis.
> 
> > +{
> > +	int ret;
> > +
> > +	jsonw_start_object(json_wtr);
> > +	jsonw_name(json_wtr, "key");
> > +
> > +	ret = btf_dumper_type(btf, json_wtr, map_info->btf_key_type_id, key);
> > +	if (ret)
> > +		goto out;
> > +
> > +	jsonw_end_object(json_wtr);
> > +
> > +	jsonw_start_object(json_wtr);
> > +	jsonw_name(json_wtr, "value");
> > +
> > +	ret = btf_dumper_type(btf, json_wtr, map_info->btf_value_type_id,
> > +			value);
> 
> Same comment.
> 
> > +
> > +out:
> > +	/* end of root object */
> > +	jsonw_end_object(json_wtr);
> 
> This is not the root JSON object, which is not produced in that
> function, so I find the comment misleading.
> 
> I also find it confusing that it closes the first JSON object of this
> function if there is an error, but the second if "btf_dumper_type()"
> succeeds. What about the following: closing the first object in all
> cases, before evaluating the value of "ret", and if "ret" is non-null
> returning immediately; and completely removing the "goto" from this
> function?
Code will be more intuitive that way so I'll re-organise it accordingly.

> 
> > +
> > +	return ret;
> > +}
> > +
> > +static struct btf *get_btf(struct bpf_map_info *map_info)
> > +{
> > +	int btf_fd = bpf_btf_get_fd_by_id(map_info->btf_id);
> > +	struct bpf_btf_info btf_info = { 0 };
> > +	__u32 len = sizeof(btf_info);
> > +	uint32_t last_size;
> > +	int err;
> > +	struct btf *btf = NULL;
> > +	void *ptr = NULL, *temp_ptr;
> 
> Nit: please sort declarations in reverse-Christmas-tree order.
> 
> > +
> > +	if (btf_fd < 0)
> > +		return NULL;
> > +
> > +	btf_info.btf_size = 4096;
> > +	do {
> > +		last_size = btf_info.btf_size;
> > +		temp_ptr = realloc(ptr, last_size);
> > +		if (!temp_ptr) {
> > +			p_err("unable allocate memory for debug info.");
> 
> "unable *to* allocate"?
> (Also most other error messages do not end with a period, but here this
> is just me being fussy.)
I think it makes sense to be consistent. I'll remove the full stop.

> 
> > +			goto exit_free;
> > +		}
> > +
> > +		ptr = temp_ptr;
> > +		bzero(ptr, last_size);
> > +		btf_info.btf = ptr_to_u64(ptr);
> > +		err = bpf_obj_get_info_by_fd(btf_fd, &btf_info, &len);
> > +	} while (!err && btf_info.btf_size > last_size && last_size == 4096);
> 
> If I understand correctly, the first time you try to retrieve up to 4096
> bytes, and if the btf_info is larger than this, you try a second time
> with the size returned in btf_info.btf_size instead. I don't find it
> intuitive (but maybe this is just me?), do you think you could add a
> comment above this bloc maybe?
Yes that is what this code is doing. I'll add comments explaining it.

> 
> > +
> > +	if (err || btf_info.btf_size > last_size) {
> > +		p_info("can't get btf info. debug info won't be displayed. error: %s",
> > +				err ? strerror(errno) : "exceeds size retry");
> 
> Nit: Please align the second line on the opening parenthesis.
> 
> > +		goto exit_free;
> > +	}
> > +
> > +	btf = btf__new((uint8_t *) btf_info.btf,
> 
> Nit: No space between the cast and the name of the variable.
> 
> > +			btf_info.btf_size, NULL);
> 
> Same remark on parenthesis here...
> 
> > +	if (IS_ERR(btf)) {
> > +		printf("error when initialising btf: %s\n",
> > +				strerror(PTR_ERR(btf)));
> 
> ... and here.
> 
> > +		btf = NULL;
> > +	}
> > +
> > +exit_free:
> > +	close(btf_fd);
> > +	free(ptr);
> > +
> > +	return btf;
> > +}
> > +
> >  static int do_dump(int argc, char **argv)
> >  {
> >  	void *key, *value, *prev_key;
> > @@ -516,6 +597,7 @@ static int do_dump(int argc, char **argv
> >  	__u32 len = sizeof(info);
> >  	int err;
> >  	int fd;
> > +	struct btf *btf = NULL;
> 
> Reverse-Christmas-tree order, please.
> 
> >  
> >  	if (argc != 2)
> >  		usage();
> > @@ -538,6 +620,8 @@ static int do_dump(int argc, char **argv
> >  		goto exit_free;
> >  	}
> >  
> > +	btf = get_btf(&info);
> > +
> >  	prev_key = NULL;
> >  	if (json_output)
> >  		jsonw_start_array(json_wtr);
> > @@ -550,9 +634,12 @@ static int do_dump(int argc, char **argv
> >  		}
> >  
> >  		if (!bpf_map_lookup_elem(fd, key, value)) {
> > -			if (json_output)
> > -				print_entry_json(&info, key, value);
> > -			else
> > +			if (json_output) {
> > +				if (btf)
> > +					do_dump_btf(btf, &info, key, value);
> > +				else
> > +					print_entry_json(&info, key, value);
> > +			} else
> >  				print_entry_plain(&info, key, value);
> 
> Please add brackets around "print_entry_plain()" (to harmonise with the
> "if" of the same bloc).
> 
> >  		} else {
> >  			if (json_output) {
> > @@ -584,6 +671,7 @@ exit_free:
> >  	free(key);
> >  	free(value);
> >  	close(fd);
> > +	btf__free(btf);
> >  
> >  	return err;
> >  }
> > 
> 
> Thanks,
> Quentin
