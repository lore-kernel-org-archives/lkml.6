Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E87BC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971EB20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Vuw99mfe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="icd2/kWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971EB20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbeGZWNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 18:13:25 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:30735 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbeGZWNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 18:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1532638492; x=1564174492;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8O+nqchpyD7KZ3gAx+bxaLTtcqOP9cfy050nikLvow4=;
  b=Vuw99mfeSEZZ3OetmmGSjkpM/W3o2fEA0MIyiXGx4rbZtB9wpY6QliuJ
   9K9Uxph4G3bE5lem+DfQ+By7upOsD7RmbkIYgmeL1GkHA66/6mg9DGvtK
   /nZQmWhwlVaOc5b09d6vOGIvtb4sOA6fVMbOia9b8Nd8ht/9CMyLlxVDt
   tAgHiqLpxaTTukF5YXZTM5pF843gITXj77v0FSba5u+RtGP2krIAj2/u4
   CW55Jx74veLHrOTDTcSAebc5rcj+nL+SxVMJOGKLgNq2nd4zJbeM4GskH
   6LalSisZFhW3FewsDTdL0GocYfq6xR8hun7+AHOEH5Gqm1oH0pt28EVXk
   w==;
X-IronPort-AV: E=Sophos;i="5.51,406,1526313600"; 
   d="scan'208";a="86512847"
Received: from mail-cys01nam02lp0049.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([207.46.163.49])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2018 04:54:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncq5qDsgRiMd+pMgz6NgapS0Z9RIW0OfPgZgWRVTgHw=;
 b=icd2/kWUAS6qnAqGf9bcwabwnborx44/OjyN2TM/Bd2Z7OHH1ZtRkaVDUexQMxvDC1W9xhZCCvvH7x46auqENwFZJ1B0KGR3nQElzBgJuuDX6dlzkJ2LZryjvCiHOolbugFUo04jAkHZGUAB6IrQg5WPvHuQrw/QuqCdC9lZed0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
Received: from [10.111.67.248] (199.255.44.174) by
 MWHPR04MB1198.namprd04.prod.outlook.com (2603:10b6:300:71::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Thu, 26 Jul 2018 20:54:48 +0000
Subject: Re: linux-next: build failure after merge of the block tree
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Wise <swise@opengridcomputing.com>
References: <20180726145624.13a604ed@canb.auug.org.au>
 <20180726084833.GA23310@lst.de>
 <a65a6023-a527-b9c6-0d78-a175d47f55cf@kernel.dk>
From:   Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <bddc1cad-5646-edf5-2253-9490717ae8e5@wdc.com>
Date:   Thu, 26 Jul 2018 13:54:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a65a6023-a527-b9c6-0d78-a175d47f55cf@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [199.255.44.174]
X-ClientProxiedBy: MWHPR12CA0071.namprd12.prod.outlook.com
 (2603:10b6:300:103::33) To MWHPR04MB1198.namprd04.prod.outlook.com
 (2603:10b6:300:71::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90d61656-5cc0-41d2-c0b6-08d5f33a06ea
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1198;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB1198;3:5ehqOMGjqV/pY7hfXAGTkWG5D9QzA00NUeEjKC8efHdu2Sm9VwZ4kBgM1QBKAhLPT63PICkZsKj560tDqz+FwGbzjK5oYDMltFk0mKXxRSwQZydUqX39b1D/TI1SQEi9X1wAkykapXuUlaLBYqF+G3whwcYvBmpP3Wrol/Pv/Mn2c4rZhoT092gd9zapFqk8hI5MAIyD0hjmlOMYIfQlILwTdNy52yKji5xSfc25PfDAhTgHhFdfooXfhKaU2fJj;25:O8RaCCVGZy2EaYPMjH1xtQNEjHR8qfE34X4sauJ50uU/WxU/aumGoUISg76zZCpb5cisaEnqZdhvpvWjUg/UZBoKPs/GdipAfFiF6/LzXKkAHSrEYEkcXiPCt8ucN2oDIMHsS682BTlNDjad2ha9p1ZPERT1ZrYeN1B3KNc/pBGV6KP25IagXclBhI3DL3I7PdHDznGuSuLg5SYPT69LBhY3bTY1XAk4UorpgLNr5tIjrcbPikPxS2BBMaVtSKpYIuegZXEYNlxt99vOaxP2S/DInnPvWa+7lN2GixPupErn8CoXqEDd1Ofkodp7GFBI7HQwRAvAbj3TPEQtUujh5Q==;31:C1mYdxGScP0o+m6d6hYpQ0s7bJj1uJaPsuRteot9JTfwUjEOk2QwMj6nrWBolElLxXEZzuTGIodr329QiLNdIfPgEDl1FpUnzCRYN9WzamTlzSK1y+7gH/lP7wGrEP5i8/GYjpryRSJKS8Tm1BHck1nIvqwndr7sY32JrnMHCD2fYVBONEQL9JFePoKqedMs3bOge1+gjIf8XeRVUp+IetTtvHCnh1kU+kACUOjeDXo=
X-MS-TrafficTypeDiagnostic: MWHPR04MB1198:
WDCIPOUTBOUND: EOP-TRUE
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB1198;20:IsV0hs2pEMo4Ik21kkDblsC39AmEgfPEYaRSyW9XCeJPUQNOndiUuTQlirBllVrUD68FzzxQzjg074NWJCpXnN6oK08LZ6g0RWINdPVpoxDIXsuA7Ho3+/hEa8GbehMzf4DTFrSaqriR5vvTsdbtOQfkvgbCT6BM/whK2RvDkiKWBtHNDDWOzRyOQPrMqU6tgvkbJsxRV1fF6ff6qQHyFAVX1Uy0Pw7rE6JgNCeEZZ6Aw8hNQx/Ldtbp8pibIB0M3/OKrVL0h39rQTJDMnEpxKWkKwz4VjiW/3l/uY8oaU5c3sDeqW7cXH1oR2/j2xBr51IzJDE30QcTyRzF9uGeljP/aYS1SdZphD38qWIDVsLTEJ/PmC05JWG9K+vJZluLVmn8sMICztlw4mvNbSaTuKzVIyv1+sH57Xs6jsmDJXCjfrKuRsEgsTnOL2ldbnuW4101cJ1YKoht9URX/ZOSiCQgknZKOx774BEPP7nMDZu/nGnUg0Wr1Eui6LiEciar;4:zES+yQ3s64KmScxMVR5nc8QLm54K7O0iZgWj8cH/SBOrTr+1W3tNQUj8U8Lm2VElZDRlwXIX3OPiikM8BEuArKxIhqYGdMwntk1li5sSJFveGiO1LN27ZkCwcn4lTM1WlH2UQQuEI+IlgEueXUl8zGEa+/1S8m4HhbNSvTK8Bpbr+5DUwVvYgRnfZlTCx3w9Pxvp7tZbISMkrQw5+ESL6+FE6P4Dyx/epmAB4/g2UTsMSW3dFDj99uVAMSAextAfT9kRxw12plrIN6SG/oFRfA==
X-Microsoft-Antispam-PRVS: <MWHPR04MB119893EF06F38049C1B601BA982B0@MWHPR04MB1198.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1198;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1198;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(366004)(39860400002)(136003)(396003)(199004)(189003)(31686004)(50466002)(6116002)(3846002)(106356001)(105586002)(4326008)(36756003)(2906002)(7736002)(305945005)(6246003)(64126003)(486006)(53936002)(11346002)(446003)(77096007)(81156014)(230700001)(5660300001)(52146003)(966005)(23676004)(58126008)(386003)(110136005)(54906003)(8676002)(81166006)(25786009)(316002)(53546011)(229853002)(186003)(16576012)(6666003)(8936002)(16526019)(6306002)(66066001)(6486002)(478600001)(26005)(65806001)(65956001)(68736007)(86362001)(72206003)(47776003)(2616005)(67846002)(956004)(52116002)(97736004)(76176011)(65826007)(31696002)(2486003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1198;H:[10.111.67.248];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA0TUIxMTk4OzIzOkZoUFRtWFRVMVJJT01kdXRPbmFWZmdFby9Y?=
 =?utf-8?B?WDVCdEFQMzdyWGFSN21EaDFnVlNtWWNwdWZXeDNMTlBwdTZEekZIWUE3UFpU?=
 =?utf-8?B?SUFYc3ZGeTRmOStoYmRVRXNNdmlxV28wa1hMNENjb2h5OFA2VDNXMytlZUt5?=
 =?utf-8?B?M3oyMVhCZzVDYW5JQ2lCZTRJVTg2THhMWkpnTGxHZWNNbVpIbDlFcHNXdUxY?=
 =?utf-8?B?Nnpwd1VNY21obERGL3F6VTliS25NV1c1YVAxVFRpTkNJcEM5eDJZRFQ1R3dO?=
 =?utf-8?B?MndLbGY0Lzd0QTN6R3hWN3NMZTdGSDlldWpwWXUraEtTdDJ0emN2TnZtTnFU?=
 =?utf-8?B?TFdjWDhlb2NlN1ZMT0hLd0lVdENZZ0RwZ2wxaWtwZ05pWkx1anlBSFp3MVI0?=
 =?utf-8?B?enVNUm5UYW9qaFd6em40T055NmZtbCtYZDNYeGZ2ekg3aHlkd1p2WkpuS3BG?=
 =?utf-8?B?R2NaNWpEMzc4TWx2WFBIWWlJTWZHTUN2ZXR3SlRXajJKUFdWMEhhZ21sWXVO?=
 =?utf-8?B?cWJvU1o3TDVpQlFXTno0TTBlUTJzY1VRaUNHVDhGaVNJV0twZ21Gdy9ZZ3N2?=
 =?utf-8?B?dEVJMGkzTUVqd0tHbDA1aHQzS09ibDVuL2lZWlBpdENmczhFSWcxYUN6Z0RM?=
 =?utf-8?B?UU0xUHFRbmo2TjNvVmR5MFFYai9haGJzM01rVDh6YUhhSmxGNFIxSEovSjkr?=
 =?utf-8?B?dERVN05BdkljR0gxdUZDbG1JSGZwbXVOcTdZTnNRRWw2bERsamtrcWVrM0E3?=
 =?utf-8?B?N1dlN1FNZ3F1VUxjak9XUGtNVzE3NFB4YnYzZGNNS2RqQzJpc3dXUWhwc0Nh?=
 =?utf-8?B?dnozZjc3VHh3QnhkSGl0S3FCaENCKzBWTVc3UjhEdU1yQkE1YmRPREZqMUdM?=
 =?utf-8?B?Vi9KWGFSSVBWWldKYm5sN3p0ZHVEalRBcHlXMUdPN0drbkVDMDQxOStDWmpR?=
 =?utf-8?B?N2xtQVQycGw3eWR4Y3FjRE1qT2xhRjlsS2xXM3k1UVJlengvWmwxMDdYTmVE?=
 =?utf-8?B?WnRaUU5OOUhINVBoODg2MUd5UzVWVW1pRFg3UFpLdGhjeU1MOElNR0hYNSti?=
 =?utf-8?B?SWszMHdjRjVrQmRXWlE3dXFzTk0yT0JRb3RuYU8xVFU0VEZEcVJZTlRncnNR?=
 =?utf-8?B?MC9Eai85U0ZDU1QxWEpIVnI1Q3NOTXZkWXIvekRoQkxlN0ROZUJUaUdnRHh0?=
 =?utf-8?B?d2QrQ1VRNnprL2JrUGZ1MkRsVGdXZ1dYOWhqMlR0VTZWNWpDS3JKQmFlcTNx?=
 =?utf-8?B?YXh5eitUaTg3cm13eG4yZDNQVnpxZFV5NGVraDFhRkpRbnB4SlRlb1JDdk1R?=
 =?utf-8?B?YWdTSURhVEFycGNhTVJocDA0Vk9rcUFYcWl4am5qOW9JSGpKTFlySTBYOCtw?=
 =?utf-8?B?cER6d0VyVGdKdzBGRHlIVmk0TEZoTVRzWllVZGFCMGw1eVR3b1BDdVg3L0xv?=
 =?utf-8?B?c3cwYlNndHRQaHRXamFEZDNjaHlFSWFydGZQOFRRaXBCWFpwSjM5K1AzVkc5?=
 =?utf-8?B?dmd5NVd0TE5JNC9VYTcvRHpkSkpHTGdiMzJCV1lOY1FyV3BnRitMS0gvQnlx?=
 =?utf-8?B?UDd1VWlzV0lweis4NzRHd1ErWXVXV000Yzh0VHI0UjcxaGdSV204Z1pKUEFK?=
 =?utf-8?B?UWNWaklUaWUyZlZLM1lzSDNLOFZVZ2U1N013V21mR1NBNVl6RzJrRTJTMk5T?=
 =?utf-8?B?YU8xa1VGY3I4Z2M1SENSMitSbmxRc0pHVm1wRjhHajJkRnUrczZtc1NBMFlT?=
 =?utf-8?B?V29ZYW1CQ0hPK25ZVlRCdzg5bFUwSC8wVkRvczdnQUhYQkdyOCszamlJNVM5?=
 =?utf-8?B?NGk3dTJnTFBnd0gwYzhUdHpWR2pTU1F0c09oNWZrcUpTdTh4dTZUUEZORW1y?=
 =?utf-8?B?SDYxWXFROGZ1bG9qdmhjM2FtUjZTMXA4TGJuMVo3WG85azhKakg5QlN2Zmdo?=
 =?utf-8?B?YURVVnpCU093MWJIWGttaEEzNlBuZ2phQWtrbW1ocXRmUm1kZ2J3Q3pZdlV2?=
 =?utf-8?B?V2grSFB1cmtWTEMreHZYbm9TejZEV1FyZld2UXljQVdlYmNib0g3eEFoS1Z3?=
 =?utf-8?Q?hAKk=3D?=
X-Microsoft-Antispam-Message-Info: l8w6MC9qJvZ+QWQPOds3SOP9V0WK+1BFXJWeqUdLaJhD0DE6KVrTUyfvdf471fUdnamK/99D7Ux1iXlSMKXEsW14dpaNfuiU6CypYjolioLezD08Ze3VaWJGgvz4BzX0Qbr2/nfYSxcCPH5mzIJR6kPe79yIEcfHJDg8L7u3UBRSXA9SjddPOlgM+fC4Mr7qnPpLy4RzvxT5szLgPDOiLlkpoXZ7piBbusWIp2zUowJz3KlxHCg3ZhJ2YE+9Ug8gVWz63BA32OTxIaaFioeRIre1+ygjziXmRK5TnuZDczRV9q4oGyC0xMwvwhszDnIyOTWQB821FOCZUmiG0nvv7BcBLHdqLrYmdgiMe5Z9kew=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB1198;6:n4M+AZga3/1eayWivhGtFNW6ZhNil4nw8m8LUl3/ZZ56t/SaYP8UclB9QN6cVJ1st3SFHMJqRILWXpGZV2u8p3g8SraWP1JUdl+6xX8eFSeaDzNzYY4ezcFWGJSKeSjTlfs5Ka2DrUZhPBnnyf/7/Lfve33acUFnUUkYxEMUqn4k/SDB+MuYqsIg9r2NmGcIGXBtgYTMV8cwTmqdf/vjyG8szcjNtdZP8wl+eivZooc+meDn33iezKRznyPsn3hltKlxtf/GCqwkdBP75CYc9+VZccaZ4cH5cIiNPRqClvjO+MHuLRWv2wTW0Xco+7b6ZzmpbHY7/jMzZPjapvzqju2DibsKhgCvAlenA6noOoUc6KkMKTLqHsPZ3vu9m5fT0MICOdhbK7Z3ya2uyrolrWAFXs5s3td10j9IvjDaRQei53oB4vOswi5/z5AOdrbCVUMtgvZNba9ScxKjBrCEQA==;5:jfh/SqUAxlpY2OpP3xiuA+OLRbgXAbMudNjeG57gkDudg1moAEgSkFhT/mHlqvq0xBcLBkHrOuBnhzSP3KcuwT4eXUckhDsfgCE+4OdzRx9ctsr+SvM5fFNtnyKft3z5IvoP1TANQN5TWBb/i7fErj0RDiVc39TKHLXXJEVyEpA=;7:sl2Qh/hQy4wYNYQjI0TgwKfH5sVFrCmGl3GJZf0WA1xvD4iDcD4MGlzk9UkFd3aH2jWrTKrR+7suSLsE4EX7Zz1n5aZKC7TtDyFkF/BzC4e04Cee6oxHNEe2SBtiROKYvdSFpBm4eRHZWqM2b/sZzskmhdvz87a82BCXlkkbiqHuULMMZ3tumI+DIpP22WNF82MuO09pKg9TjNI8zBnjGpAFfVRFpw56UNf6vXH656QKAp5dxwMHxHKZxVvyP22t
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB1198;20:n30JeYSBvgQjDNt7x+3UoBO1aYWFhnAW3J5QrVwACIbG/ZHYxj69RlcZx05MqdH21LxKlxClwtKLAeSA7sLVEB4nhJ+VL3UiloUH4kH9q7MrFItVbQcN80lHFSTUnx/bo/GXy7fPFzXjQDdumaPU/2ev70WvJLpes0hLFXOc/+c=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 20:54:48.9368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d61656-5cc0-41d2-c0b6-08d5f33a06ea
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/18 10:48, Jens Axboe wrote:
> On 7/26/18 1:48 AM, Christoph Hellwig wrote:
>> On Thu, Jul 26, 2018 at 02:56:24PM +1000, Stephen Rothwell wrote:
>>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>>> index 86121a7a19b2..8c30ac7d8078 100644
>>> --- a/drivers/nvme/target/rdma.c
>>> +++ b/drivers/nvme/target/rdma.c
>>> @@ -891,7 +891,7 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
>>>   
>>>   	inline_page_count = num_pages(port->inline_data_size);
>>>   	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
>>> -				cm_id->device->attrs.max_sge) - 1;
>>> +				cm_id->device->attrs.max_send_sge) - 1;
>>
>> This should be max_recv_sge.
> 
> Why do we even have this conflicts to begin with?

Hello Jens,

A detailed description of why that change is necessary is available at
https://www.spinics.net/lists/linux-rdma/msg65954.html. As far as I know
the entire RDMA community supports that change.

Bart.


