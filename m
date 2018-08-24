Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE438C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B36920A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Dqa5l5WT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gocFLZ8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B36920A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeHXTfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:35:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33902 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726458AbeHXTfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:35:41 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7OFvl9x006538;
        Fri, 24 Aug 2018 09:00:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=3U5f+ZWiCLqqcdbUz34FPryV4bGklg3bMa5Lb/rq9qA=;
 b=Dqa5l5WTGpMDNUyGyR8l1r5mOxzD+dILmZiPWxdKGQaMBMaKtPaXUJfVuichz1+2EKK5
 MgT2XUMMCf6WKnRA3K0qrQgujQ5AUo+0GY31XMA/tUObgPOKjR7VK2cw7GWzzFZbsIL7
 hU9Rb8+0jqjeteuWPBvfSSONKU0JuJ2nR3w= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m2j4a8h8h-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 24 Aug 2018 09:00:11 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 24 Aug 2018 12:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U5f+ZWiCLqqcdbUz34FPryV4bGklg3bMa5Lb/rq9qA=;
 b=gocFLZ8pEKzFe+i2dRhOSOEjs7DA7zVTZS39HwVHZRc34zlbUljQbQPB4mq/UNgAd/OOcOUqgh3E9SBzKPiwHlvAEeLZJG4mCAH4cysFFF6UCZBoTEXksgqNGs/X/C+Y0GvgJZe1K15eCawgk8dcYHhciOLtO2uzB7nl5WXLW/M=
Received: from localhost (2620:10d:c090:180::1:a094) by
 BN6PR15MB1122.namprd15.prod.outlook.com (2603:10b6:404:e6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Fri, 24 Aug 2018 16:00:07 +0000
Date:   Fri, 24 Aug 2018 09:02:55 -0700
From:   Dave Watson <davejwatson@fb.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Mikulas Patocka <mpatocka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, Mike Snitzer <msnitzer@redhat.com>,
        <dm-devel@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Deadlock when using crypto API for block devices
Message-ID: <20180824160255.rg7lgt2tcbwjc5xn@mmilisic-mbp.dhcp.thefacebook.com>
References: <alpine.LRH.2.02.1808231621220.8560@file01.intranet.prod.int.rdu2.redhat.com>
 <20180824021010.hfar7gasp34ddrib@gondor.apana.org.au>
 <alpine.LRH.2.02.1808240659320.27014@file01.intranet.prod.int.rdu2.redhat.com>
 <20180824112435.ggizlqrymuibm6oo@gondor.apana.org.au>
 <alpine.LRH.2.02.1808240837120.11243@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.1808240854010.15479@file01.intranet.prod.int.rdu2.redhat.com>
 <20180824132145.2zsnqwbih3iygeeq@gondor.apana.org.au>
 <20180824132231.t3narmsfcykseeee@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180824132231.t3narmsfcykseeee@gondor.apana.org.au>
User-Agent: NeoMutt/20180716
X-Originating-IP: [2620:10d:c090:180::1:a094]
X-ClientProxiedBy: DM5PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:3:117::13) To BN6PR15MB1122.namprd15.prod.outlook.com
 (2603:10b6:404:e6::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ea88f5e-5b9c-4722-2a6b-08d609daa9a3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1122;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1122;3:4w9JcxsTAjCrYLjS6K100ZXFz6TkCscc2tvhMWaPzkKxUBEIpxmM/V6Y2jGdLyAZFd5BXEFXmjP2Jhffp59zudq5jq9rChc17PJ4T+lSUHbtnPKkC/uWZ9WRStO/++12hY2E9Rh3P3XQOY/O1L5vVeWu+Iuqx/Ev6z1A0iRnR/XwfiWsPafQQ9yzX0h6LZR8fkm6wlUwCrALM6B2W4BDcmKx9zgVjrQmerzjqWrcRRqIc9P/vUNEOIF2CpLJFHbZ;25:1yYdNZ7Iu7Hi4pMMa2Sm4dBCqJP7L+GADdOX7f5oqtHs6icuLmFFf7CCF8TFa/3qnD0vM/zLcHCDylHTgajzqiGs+PbNztk20e532Ev76cL1nkXa4hqqpf/ojDN3gIqLkjsoM+dkC++EOCkcdzlQ1ALvARLkDM4xzzJJgi8igWlwCZ4fo9RrMryus1mFbMzBEP72cgdJn8PI95GBjL2IKd4u5FboES8KAyLt5B0AxmEEN/fdiIPP6DcH/ufk1eZ7MNkUs4saIFfocjuRSArhKLKyspnKWLEn1EpuPGx4nhjgkTHbe6NfYIWmown/xLAqcyF5/cAffZGsZlXJP5AykQ==;31:nsLcr2EavlLiUVJKz7/rOATEQNZR05JMDSgQ81axrp1sSFU+Gn8repLYO7DILhBXes9dzyCiOfATOhToo1QwkYjM6HnlNBHOnHzbRwrtpUhahUkdMu34ree113LgUQ/oGtPVB7hEltVU3X1M9ppEaFgSrTLKRXRDwd0SxP0xPhH6GEaTIGTLRx5+IbtCvR59nGwy3Lljai+aW8P180HINJOUHD4a/+xmfdQYoIrBvfo=
X-MS-TrafficTypeDiagnostic: BN6PR15MB1122:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1122;20:qI8T/6XsFUyDPPyC3Txjo4pwNTyfcSEQ4Y2mj4n/CyYEiU+Ihi63ftfKdgDH15yQzrsevq1UD/r8G0i8agWEB3KxyaMG39ISZPIfv1oFNbnJiITnfeZCqfuPT5aeklwaaxI0tnji/0026IFFpZOsuUHdGvoqPLk6qPFAStxpnuYaO9b5/x9DhO2M1X6GhPvjXDxTHFkuedKIGvgAjbPh9aWi9cSyY5EiQN1C1VaJyphLYaLDi/bdMTSBWNMnBVVUk+kcDzfcwNeFUvx1JK8AyJaUbBn793Ven/+Fp8IQXlPMeKFC+LRd2il3ptstUssIbKlT2Hv9ORSMuqk+RvQmaiMpOl6Pd15X+wDwzrndSctUr9KF8E9cIyg9U4RvvaiIA6gJ281Hd9Jx2I58cO7cUKbamgM3wRiFwsHXLZOHQd4arLKUCB54tIduFjMVY+MLWKPLwlUgH1hD9P9tUt56HKTnAdgUK81ML3L2Ln5WzGAPu8CmJ2z/7wbC/QaPSiYb;4:aqTKVJA7x2hnGp+hysuof4GTvzXiaawuFk52qXBtJXYLVt8aBOsoyO9j9NcSlhMvuaBKkVCXOc+2EB5KixIYDQNgfmnCPVsHi3zE6WfCNTpL3d7bK6sbnZ3K16UIcNXeu1xSV4jyc8IGtr+jm3BFb48fNj0UcfrlrAQSTQV6YvIxikNwnj796fzdxWh2q6HEyNDcH25eTtH5LZQ4C5FT14JquzylS1QHT5QR4jpCT4U+jQE8w0QJoVAdokw/k6CFEXj/YkpjFey8TltGC3gy8A==
X-Microsoft-Antispam-PRVS: <BN6PR15MB112271872A9460364CAA6102DD360@BN6PR15MB1122.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699016);SRVR:BN6PR15MB1122;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1122;
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(396003)(346002)(376002)(39860400002)(136003)(189003)(199004)(81166006)(105586002)(9686003)(6246003)(93886005)(54906003)(478600001)(53936002)(50466002)(106356001)(2906002)(229853002)(6486002)(8936002)(47776003)(386003)(76506005)(25786009)(53546011)(4326008)(6666003)(5660300001)(186003)(97736004)(305945005)(7736002)(6496006)(52396003)(33896004)(68736007)(46003)(6916009)(52116002)(6346003)(86362001)(316002)(446003)(81156014)(16586007)(11346002)(1076002)(16526019)(476003)(76176011)(8676002)(58126008)(23726003)(486006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1122;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR15MB1122;23:yE2cvYg2SwqCpF5OifAgqX4C53U1IkLwfHjLN9gzh?=
 =?us-ascii?Q?fFdNIn6buQ24UACUW6mO5zWj9W6NvdBG9v2z3GjxOUqiH8C3h85jUqUTwSbB?=
 =?us-ascii?Q?+xCLCgC53nFkZFYyNhwqnPNCKHIALEzUq7flGjxseHZEWgpcu8ZD+Y8RGuyf?=
 =?us-ascii?Q?KVqgxERlqb4gXO1vmczD85JtA8HnW9+C3n5Phv69gyiDTcikEiPuRQ3n0jhH?=
 =?us-ascii?Q?uHMAUo8Awcm3DvZKQUFz6nDLx85hYrG811qxSRA9XRkCuS+YVUUx5zALg5iZ?=
 =?us-ascii?Q?3AxwJ/T7bKnth1Dmyxnctg39W1TDvwWPXCMQKJA/bKbiXg2kr6EGoWNoPSt1?=
 =?us-ascii?Q?pZf8kaD9CMafIVmOyXie3BW9qjK4YvJovwfZM1+ZTtQVAAw4i/worfOrrriF?=
 =?us-ascii?Q?DnkpcWwBXuDjqllPIZXXKCWQ9kFez1fOHpEuwQV0H9q9O4IOXUhf+nPN0y4Y?=
 =?us-ascii?Q?y68IbA39GMvI0WB4E6Nvo0VgNF70oIodCJNx97n3sB5AjMpKxeaCqtdYcELz?=
 =?us-ascii?Q?6dVw9zqy09dSQ+9ye5COkh6pZWJC9sFyxL4pby7P5IkrqfVd9DF6hNiHTV9Y?=
 =?us-ascii?Q?Mrtvs8iMoexAVwQcgLE8rOvoVO3AgXdeOIaIqf/326XsgJ5GOsk8Tbq1nu76?=
 =?us-ascii?Q?Q5sIvalJ7G1Va0z9yaq3qaEn/vMwiNRjRD9YRuHcZgKODhpMQVU0yMU/dhdL?=
 =?us-ascii?Q?4sRyzNKDk2NcBXQId+ugn2sz7C7izCGjT7oI3LJmhJKF/imwtdct2EqWZG1o?=
 =?us-ascii?Q?h2+nOQzJNmhFQrOI0eLxTEAl1VpuYQRBsmGHK0wXvijhDhi4caWJ7xBmujnj?=
 =?us-ascii?Q?hyEZVmvNJHFCW+U3YDmB6k+tXVyfIkNvsJzTmN/tACTlY0KhWFpY/6L0KDYy?=
 =?us-ascii?Q?NF38VuonaB/MnVcy47ylJMyM0c8WWXV37etiLUEa8G/eIyys2tfElgd/v/Eh?=
 =?us-ascii?Q?ZLaEpqjat8k4Wy9/dPx2IqSeb8jtx9WV9T4KAHV4ugm/hl97ksH9+asCe+gm?=
 =?us-ascii?Q?94YHRyFiFePE99phJDlT23yxFU2wZiqlHPVAhSF98KPcNlcFjPMguj2sOPY2?=
 =?us-ascii?Q?fCMXBluFgpFWJoHPTjRCqlBnm2ZISZKVyXcV6uRhF8sf41KpfqqobVQxFXxL?=
 =?us-ascii?Q?Z6KtWUF51yz4dxuZEo2IW2HdN4ut33F+cc2HV5E1RcUcLbUjYvZ3lNnDIwVT?=
 =?us-ascii?Q?OmFaU8c+skRFztQuOBKpWJlLwxjoz4frFLF46UnludL0rnynufmke9kH83ag?=
 =?us-ascii?Q?lPXH6zOs1yg2kwlOIEC94dj457GSdUmNiz/Y4H8?=
X-Microsoft-Antispam-Message-Info: pKNm3GOqG25+PCxmR7oQP0JrQK76eCCrbMKQdmFIFtudpg1G6Ug5XwYzDnuwS6fzgRNPxceEwF/TihMAyqUpH4p2QHxAg1roazoL6APto8Cp26jut/Cg7sKOd5y0jK55/4uzNC4PhAMrcdeONB7iP9z3VTv1zTyMRx1dUudeyWfoOHp7XiI6Jqu7yaV2YT53tFE98Mo25r2V0bK4agMttxNQayh7EPCxPuzhESGN4KQqRvxmmHnfWmz1aU3qDXUe+wxVmUzlzs1SwiRTD7s5dvUhca5zbH8pU+pBDd4mCgHRC3T7XuJPjbGhSQpxauAPdnU4bzR2HBigP26RZAvFR7Q+OHQYxlhAVlD6dy8uHnw=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1122;6:6WAMNx5nfIRw5iHlw5P/QvoY6vJgUD911QpKjMuUMMCbFj2lBbi5sKWXiOFYdWeds1GlHDynAk8C3mAGSUvcOcCJOb7l39oIpnB7SAS+yB82A16QuDrmkSCc7Q60a9dO/Eb9VUrnbSuvV8HjY3TACgRjgR1wIYNtU1GEfwXuDvuugNpi6ntLyXVAEQg2utsSDR21eqkhBojkfwPMwVG2iScHjDwb0AMdD1WXBntmeedATpa5Iue59dIFlRR3bcr1JSdaVqGAQgQCrTu6CsvfLHw6s6dA99WLtbWqisI1i8FLQhf0ZLUXGOH7c+oGoCZJwQZ1n1uEQKbuCgBjuipO3CQHWnqfkNdaJPvxX58qRMF2pG/aXaUEk2+qIWRA/Pyct8TBwQhoG8f5xbH9b9JpZ+VSqEBST6+0FqOosi9tzIKFsjRopGptOynFNzhvXFmjkBoHDp+4d7mMFtcV9EpLFg==;5:7qdYaK+t+FZjFZdlRgR7EctWH7zJfgkikiPufIXlNVHNK5KYtPnEA8DKbSliij/uxu57mcDb+xon8avev5sI/PWBpuSJFAs2/yju0SUa7EX+CIKMjArqCn97RjbMwoj9zhO+5GJWMVYrwwJAL5D9sM4FBpabTmKnDp5sU4PwqHI=;7:0iS+IbrMH3CaLIxiOdSsk/a83eRiPIx0Vu3qgT8ft71fi+EhOJ0c5xJbuOMGWsNz/5CVNDL+uubmuQMkMjT3IKOw5+Vus7SbbFr6lUt/kUuLy+ABuxFHl7gOtLKQq8Cg0GH9PEM4kNiHGJ0IwkGS9ToBoD70jDjcZjADcGGt+kpNnkDvUwqQJdYVe/P8UeQm8qgjZSesItV8QEsMvIriJFVOPY12U0qVWIlNDoNJ+n6izy7G101tGpzvkE6a5xA8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1122;20:WN+yCN+mZojCKVTjV9x5yJ2l83TPd/GAY1VOGaTkUbfvS7h5w69Snf2vQ8xBIiAnqaoVgOpdGHCnA9rBXQpeutXoTlg7pBxVZG+O8CxKtlC94/d/99ggqjGubiGisNpkUUMHNAArY88Vfo5dGbkGsn3jh73pVX+XPCNhT27LNUc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 16:00:07.1225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea88f5e-5b9c-4722-2a6b-08d609daa9a3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1122
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-24_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/18 09:22 PM, Herbert Xu wrote:
> > > BTW. gcmaes_crypt_by_sg also contains GFP_ATOMIC and -ENOMEM, behind a 
> > > pretty complex condition. Do you mean that this condition is part of the 
> > > contract that the crypto API provides?
> > 
> > This is an implementation defect.  I think for this case we should
> > fall back to software GCM if the accelerated version fails.
> > 
> > > Should "req->src->offset + req->src->length < PAGE_SIZE" use "<=" instead? 
> > > Because if the data ends up at page boundary, it will use the atomic 
> > > allocation that can fail.
> > 
> > This condition does look strange.  It's introduced by the commit
> > e845520707f85c539ce04bb73c6070e9441480be.   Dave, what exactly is
> > it meant to do?

The aesni routines still require linear AAD data, the condition checks
that the AAD data is linear, and if not, kmallocs and copies it to a
linear buffer.

Yes, the condition looks like it could be <= PAGE_SIZE, similar to the
one in gcmaes_encrypt.

Yes, we should fall back to software gcm if kmalloc fails, although
AAD data is usually small, and it is probably worth having a small
stack buffer before attempting to kmalloc.
