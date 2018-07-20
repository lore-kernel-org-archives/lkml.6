Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C621ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD810206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FF8iAn6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD810206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388469AbeGTNWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:22:00 -0400
Received: from mail-eopbgr680040.outbound.protection.outlook.com ([40.107.68.40]:16576
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731075AbeGTNV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCXLIXqYqZQHnbmYXqW+WUkqcfnkWhwo2ncxzoSwhwY=;
 b=FF8iAn6JIPKRFcbJctLuN8+T/yCdQ83j2sKq/VRB1xUYz5PYdqmL5huhDRYptsAw5cnGfv2HZPW6C7Id0an+KZe4noS1YCZOE8CwwduiG3R+H0lM5wDPBNAeLaW4cS/IvWkXgKce6TgsssIWrwjNtJaePvUvjjrlzB9vaJmrjtk=
Received: from BN6PR02CA0074.namprd02.prod.outlook.com (2603:10b6:405:60::15)
 by CY1PR02MB1628.namprd02.prod.outlook.com (2a01:111:e400:5299::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Fri, 20 Jul
 2018 12:33:54 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BN6PR02CA0074.outlook.office365.com
 (2603:10b6:405:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.20 via Frontend
 Transport; Fri, 20 Jul 2018 12:33:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=bestguesspass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Fri, 20 Jul 2018 12:33:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fgUbY-00016S-Iq; Fri, 20 Jul 2018 05:33:52 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fgUbT-000886-FA; Fri, 20 Jul 2018 05:33:47 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6KCXkWN006887;
        Fri, 20 Jul 2018 05:33:46 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fgUbS-00087t-9V; Fri, 20 Jul 2018 05:33:46 -0700
Subject: Re: use the generic dma-noncoherent code for microblaze
To:     Christoph Hellwig <hch@lst.de>, Michal Simek <monstr@monstr.eu>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20180719125440.424-1-hch@lst.de>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <434e2ef1-3e3f-46d5-a7d1-62ed0e217da0@xilinx.com>
Date:   Fri, 20 Jul 2018 14:33:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719125440.424-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(305945005)(65826007)(8936002)(9786002)(5660300001)(2906002)(356003)(336012)(50466002)(23676004)(2486003)(4326008)(106466001)(31696002)(31686004)(186003)(77096007)(63266004)(426003)(26005)(6246003)(11346002)(110136005)(44832011)(76176011)(81156014)(36756003)(8676002)(316002)(53546011)(54906003)(476003)(229853002)(446003)(64126003)(81166006)(47776003)(58126008)(126002)(65956001)(2616005)(486006)(65806001)(106002)(230700001)(478600001)(41533002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1628;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT006;1:g/BmR1RSTFBwkN+mRJw4q16thLj7GxlsN/8ktLgRaLHJ2WEk4YktzhWVjXd9N0yIDfxF1x9y+o3Nfabcxx4MGi1MNryCtFGkKtx4MtLp2sT1My2JFDlTBW16qd4wzJJE
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7d0e152-59ab-42fa-faeb-08d5ee3d0db3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR02MB1628;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1628;3:bpySsGzV1FZBa6zma3qkjLZYLUp3P2NwIlLLxmpncWP9rc3kk2tTjgB3jnrRPL9iUG6Cf0pCUAji7524qEEElKxURrsSuEyjiDlfnQeeqDG1yOX7mmzCh3SOk9umV1APRSN4t8A0XbcgVkxK/0gmIqRgb7mc/ZRMnHtpkh0NGFiNfM6VD/1qTu4XkwdUHh/Upr1cmyCOXe1YlHUmrx0z+nooxe+oy01IBfx7YVqV/tSapgdni0ZKhUhcNiTaCFoxIpafCoSdTDrbd//qsXB2hkvsPylEDYIjwMvbeYJQ4RDD/h7l0EeMxFyqMunVo9UUsmHn2KBx4e7fSrgbdLOwhp/3c6q2qiQ28XdCvxZAiIw=;25:In13EeXIewG0uJjDgIRgrpMitaJc5C3NtHP5goYg6sWvYQyhTPR2eI3JmMqaoMTLzv9LzhLAsWE43xr8IeyH8GXsD836kYEzXUxpfDcsLpB/UA56ArBlPh1zCNMoll7JZZb38++/yN3DCuIz0i2Gt37V7ydf1O/FblcCSZQOGpvmbctFAZDA4r2ls/yX5edkcunJCPRAti82gWf9Cvnw6ClkAW3k4JUzEFjFdPklHGx21h9ph5Voe0NMBvM4Jj6SKFIWJ/lZmAFLrB2VjG1jLQ/ie0ri1j9/UzwYy+Izrsnwyobqw+Ut2MfnuBZi2LPVHbro5fWTwEHAJ7sV0YemGg==
X-MS-TrafficTypeDiagnostic: CY1PR02MB1628:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1628;31:rv7UqcTntt/zdcC0USHH6UdX4DYIwwz/iKR4hnkTQJ1MOpvzKzwHItRC4xni1xUuuuSpVwN2G4Z5t5baEnjYYHy+RzyaYeYUsfYaWejnSOEtKvKpUuIGdG3EbdI5wudp0ifDLHOQxM1USET5lRn6JWOkQIKEiTA3OMhisDXo7iqwSSyNH3c+ZIfCXRVDAv+EG127Uz9J1qW/9TKp5eAxPWSt2aJA+IIOrUFoLSb32ug=;20:RuCfOpz8ZxCQS9ONHfCtY1GVeg329hroXt3ra/JsxIpSgg1clyhVWzFhAL9XAf0rf3gPIS/eGZnLwQok3/B9MemhB9D/j2Vjre3SyUmC0Hs0WB5yiLzI6HVVlamLJyRZtIBa/9+75kT0gIIzeWESRQWbnPBoDGZle4HRcjpKeHPnHt/5fgBp0/0KBoRDw7pxxMpL/h5kF4W+iHXk3szyXeYRDf2nJlvj9lmO/tGIm3pZodbMAggDLr6eCdhug4UmlQ9/S7mESw55NXW4tsfBn38SP87gOWrZDGUM9NjpSZ/1/zecyG7itCEF3fx6ynP/A/WCwxXvyau2ZmuWGcXbfUdp2kuc/ESs9CzAA+u2Qnr95utN1+u+jvQ1VSiZsh4K3HcHxVB7ZwiPJphlISiGi5C9xoRVIosxDJy35a4ukC0y8eV1K3+M42yjaJq/PSoi2y/OlAm0TR6mmFwUI/roP+KB4VIJvbiiYIE3DufjRjfEMfCuhtopuCgVpaGSRja3
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR02MB1628465235351AAB2DD29648C6510@CY1PR02MB1628.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1628;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1628;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1628;4:/R2Qz6IhjfsHp9FVF4dExsu50Bq4nsRaqQMMnt/WJAG9HMk1jSqiHtbH73PERBi17bc7VmvSszf8blMeZeCR8j3MlByoDpiPCZJArgWd+9oofAM+0v1u4XGdxHR1Iiqat2Idi1jOAUmlVEke3mA/+cEHgWe47GsV2YYacTe0XmeQ3HAVguJErr1NZFZPB9Zq1EGunQ5oMxo3dueCa2F2glqFzhwHJktYJj9PZPB/PvZ3eLUhHbnkNo9NEmMytcbTXddefttlFdjIoR5ge5jDjg==
X-Forefront-PRVS: 073966E86B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAyTUIxNjI4OzIzOmliZnpkYjV3NmpXdnNyUW44NFN4dmwyc2lL?=
 =?utf-8?B?KzNsYWIzQjNMYi9JTnJpUlQxSlVoSm1tQVRFTjFGa29vOEpnNmlPY2pnNUZE?=
 =?utf-8?B?cnU4RFNjY1R4VnExd2FGZ2dOOW0yZ1BpOUNpVzlyWmptVTB0aFMzaGh6bFJO?=
 =?utf-8?B?azRQNXZSVENIbEZ6OVpFb0tRSVFCOHlOMTFiY0hrYVlkc0FlKzg4ODhDQUs4?=
 =?utf-8?B?Mk5PeW9ONnJ6OTBESzVBRlNrUktzcU0zSncyRlJtREZKZWFQOGkydWhWdis4?=
 =?utf-8?B?SlVzN25pQjNUeDdMNk9BOGNHRnlkNEVQU3I5Zm9ZNzBza2gwUDFJUG9oQWRp?=
 =?utf-8?B?WkhIbFdKRWhkSWNRK3hkK28rc1Z2cWJobmxHVFhteGIrZE02SGZ0M1ErTVZF?=
 =?utf-8?B?TWNGUGxLK3dqa1I1YnBRZjIvOUZLZUlRZEUzRU0xV2poWVF0cmEvbUVsV29G?=
 =?utf-8?B?WHp3MDlOV0NvcFdXRVUvNUgxZkZsaTRNMWhJOHVpTnhkSVo5SWpmOXZUQzFF?=
 =?utf-8?B?aG1CcDB0ZGp3TXB2d3EydzY3K2JhOUNJZ3dTQU0xZnMzcjBNWWpCc25aeWtK?=
 =?utf-8?B?UUN4TWZqWUtqNHZFM015WFZBV0lQMTdBRTNIaVY3U2dVS3IzcUJldkpxcTQy?=
 =?utf-8?B?N2NETE5iNkNsanVRVFdNMi9hN29kWVlTdGNYTWlMd25hNkZQdml4NGF3Qyty?=
 =?utf-8?B?MVFTWlR2UGY3SWUrRUdreTE1Nm8vbllVUDk2UkJ5OVJSM0JHWEZVSEpCai9D?=
 =?utf-8?B?NENzNmw0SmJxTG1zZmdLWXdBVlZVSnd0R1NhaEJPSmR1MFhvUjRSRXVXMzVu?=
 =?utf-8?B?Nm53M1pRZjlSYy9qcTV0R2hPT1J0KzVHb0tQbVlDNzZZeVNxRitNb1FuNm84?=
 =?utf-8?B?V2QwWXdJNUtwRjdieXJSOEtOd2ZxVlZUWWMzbVpMcUppd1phdENacmlETXpl?=
 =?utf-8?B?a0JDeW9XaE9iRGEwZkI0cUMrWEZyYUQ5QlFnbW1xVGJuUnZJSWgzRm5zdUs2?=
 =?utf-8?B?bi9MRUZaRHNuU01mRG54MWdFd29IcGMweFM4eUV3MCs4V2V4UjZUWWU2cVJ2?=
 =?utf-8?B?QUxYT3RUYk9iLzY1cjlyWkRkc3FXSUJLY0lyUEs2Umdod3R0aUdHVFRKYTRa?=
 =?utf-8?B?STI4Nlpra0pCc2RlVmpPWTRmWUFjbFdVRzJqMTl2M1VmN1ZSdllpZEFFZVQx?=
 =?utf-8?B?TkdOT3dFb20ycVQ5S1NjbTdhSFhtS0trZnhVZzRwb09RcmRUSG9LUVA1cUNv?=
 =?utf-8?B?bnRkV05RcEhyTE5lK1JXYkJ6dVc1SUtUeTJ6cDR0SWtNWkhiYm9XNnNhT2lT?=
 =?utf-8?B?K05VUGR2Q2hleVNYNmx4TmYvT1RkaU0vcG9WdTNFZE5YYTdSdVRIbktWQ3Q3?=
 =?utf-8?B?cVFTbm10VXF2dWVQUjNmazljN255bitFNTM4dVlvVEVGeVErcHVWS2ZqZ2oz?=
 =?utf-8?B?Y0VsL0RiamNVUVdMZ0hOM3prZVJvQUNJbjVKT0FqcGloSXJDLzFlT2s5SDNI?=
 =?utf-8?B?bE9JQUVFWjV5cHcxSE5QQ1FkZDlSMy9UN2hoNzBERU1UKzV3L3lsOXlHRHVT?=
 =?utf-8?B?ek1VLzAzNzVsRmlVd1lSdTVucTR2Y2QyZ3c3aG45dzVIZ284aHZ2N1pBeno2?=
 =?utf-8?B?LzdHMXZNaFRSTy9Cak5kMkJBSUc2aEFpYTc3Y25McGdOeUNvSWNQSFhsc25n?=
 =?utf-8?Q?m+rKG9blsBoJnnRyHs=3D?=
X-Microsoft-Antispam-Message-Info: 5J7bFB2JrO8lEDiCjcoHdkfTRXSqhzhDS6a08TfvYEPo/xwjv2qb/SAJHfBGYq+gI/EjmE870KWKIf3fdqD6kZV02HIi+ywyNoy2GUyMarZ1QKQtrFIYE6qTpflfiy37s6dzwespNMFeHRITt27O2rsYxO4OBAipI4qLXgMUPYfqT1Jyip7o90b/QFKpVY+UELryixIc49TvKc3WlLpqBwW2H50sYxg722SbF7+5DmzOV5KbfvtFFc36VQ1JDI/LH7dxNUEmdJ7i61eWHxi8txjc83zp9Cp1TF1299EaiO8xvbh3ZmS9CoXx6P52t3XToRjP1gv3WTZ87RYpqnll5k2dR8xaSCFMz3He1mjxF/0=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1628;6:k5eG0uJMbBbsGGKivwmVmQFZUrjsko72fLa/CAAjz6RsKS+tyQMu80qYSIwrVuYIEC0KldmD3IGL3xQ5j5VLxAJTqFclB1I9uVZXi/4+Z0sUhgps4wCKWcz16LnNT1ZkepjAzmKHH+rOCUpmJGakEsMDih5f0sgRGSpZQkAz8nwK75EM8Q+S9x6272aElN2bFvvblkp31FALvOoOMdAFkduoFNTZQS8KZrE23XHybmWpwvNjizWShbMBY/Cy42cFNZZk6TfwNeAANyPmtKrtR8q/bcQe0Lt/WZTHeVYmrbi/v5iuKvyyIIhe9IQJ+nHlbYUd8sqF41TUpWwvmQjh7p7F/sIUiEYHPU3/39+Y2BLiVOK7owgAyutcXRFbzVElZi1KfNvUEovtHa6WryskoIy/tiUBj5LfC7kN58tJLxh0nhBevMPz8ld5LKEC8BdZLOeKH54Yq+J5X2qzW8RBIg==;5:GFAJctLFnfhzwbXQufKCF3x4uSIuXcVDMz384q7vq/swpNOOE3y3WBg1d7knjCFnavd63z7WpWGecujZaBA+6PaqmT7NFqxTkPSSZUNZ9z5wjdvLWxZ1oXMPSm98rR0KsjI13AcVKUIbfeIQmhzN7tGVipy0FXT6iOWZEVrkC1A=;24:cjH2kDPx41ciIiMPO/CBMUugnkVjdkSSQPrGOFxEFPNKqj7rIQMWKeBqEV6xjYHUn8I0nKDW6Tjn7xcF1QCY/iGb/thixrCQVkl9CKXkAG8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1628;7:eHj6kwqRTK6KbQchqLd8ctpIP5CYr+UfXK3dxhu9j3JrL+QGuFTEvG13WKH7BGRtQ9j1XgTuEskt1jjZ40jgZnZtz3VuLzv40QJt6N/2vJyiufUK6vGYQ2qBKoPWV6dnk+xK0fxbtXimVdqlG5zs9rCU/Fywne3WK579nPmWNOmjtlHN+ZK4yxcd6c2PpPrh6TVq90rjvf+XDXkC49HmsPG/N3/69tiQPYtBQgCwdzM/GvN5qXyQcD7Zy7L53ez4
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 12:33:53.0295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d0e152-59ab-42fa-faeb-08d5ee3d0db3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1628
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19.7.2018 14:54, Christoph Hellwig wrote:
> Hi Michal,
> 
> can you review these patches to switch microblaze to use the generic
> dma-noncoherent code?  All the requirements are in mainline already
> and we've switched various architectures over to it already.
> 

I can't see any issue with them.
Both applied to next.

Thanks,
Michal

