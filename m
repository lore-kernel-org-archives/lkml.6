Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8629C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A35E2156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="P/ssP6i5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A35E2156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeI0OKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:10:41 -0400
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com ([104.47.36.59]:42448
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbeI0OKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUvASUtQOHJ0NkQSLmOB3EG/TvXNHkd81zI33/daFpw=;
 b=P/ssP6i5CPO/1x6tCDOxYvjc9TIQt1QwBdXx8jntGOf0qEt6JEnNhLzqO4W0BsP/LVvF+AK110xnW6LB0Q7I5osBgxB9AEfN6NU+8UzzBAkLCzinx1lcY/STLMoQOsxPHOWG02J30/nbz78F+ApJJXR3hGc3YgFo89OzT7hQHes=
Received: from MWHPR02CA0009.namprd02.prod.outlook.com (2603:10b6:300:4b::19)
 by BL0PR02MB4754.namprd02.prod.outlook.com (2603:10b6:208:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Thu, 27 Sep
 2018 07:23:11 +0000
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR02CA0009.outlook.office365.com
 (2603:10b6:300:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Thu, 27 Sep 2018 07:23:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT008.mail.protection.outlook.com (10.152.76.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Thu, 27 Sep 2018 07:23:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53128 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g5Qdh-0005tZ-61; Thu, 27 Sep 2018 00:23:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g5Qdc-0000Uq-2I; Thu, 27 Sep 2018 00:23:04 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8R7MwWE008694;
        Thu, 27 Sep 2018 00:22:58 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g5QdV-0000TK-Ng; Thu, 27 Sep 2018 00:22:57 -0700
Subject: Re: [RESEND PATCH v3 1/2] of: base: Introduce
 of_alias_get_alias_list() to check alias IDs
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537443710.git.michal.simek@xilinx.com>
 <CAMuHMdW5zze-KJhK=diR-WKbhO_vsMV2b7WuLHmcT2FtRD4J7Q@mail.gmail.com>
 <d27b381e-f091-91dc-cffe-27789583f949@xilinx.com>
 <CAMuHMdW4H6pjpijU2SX1Z=1Ld7CbBnTtFVwp3gac9toQc4iGpg@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <56c81d1a-e2f8-067e-4908-686cd83d478c@xilinx.com>
Date:   Thu, 27 Sep 2018 09:22:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW4H6pjpijU2SX1Z=1Ld7CbBnTtFVwp3gac9toQc4iGpg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(438002)(189003)(199004)(34290500001)(336012)(11346002)(26005)(77096007)(53546011)(446003)(2906002)(2616005)(486006)(476003)(126002)(14444005)(44832011)(93886005)(65806001)(36756003)(47776003)(65956001)(356003)(186003)(31686004)(426003)(217873002)(36386004)(31696002)(63266004)(106466001)(4326008)(9786002)(316002)(230700001)(5660300001)(54906003)(39060400002)(110136005)(8936002)(58126008)(81166006)(8676002)(81156014)(106002)(6246003)(2486003)(65826007)(23676004)(229853002)(50466002)(76176011)(64126003)(305945005)(478600001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4754;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT008;1:eb+R/uGI/3WrKo5n9AqoHqX+SHGHqSJZohUKEDy2M4YVssFgkep3eNLCeghHL1zWnqmIwfDM0IOHJ2doM8NiXXQIZh9NYLh/06qkFYthhmTKE5M3dqyLlMfcFFIi7ar8
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d058b46c-0c33-4901-aa00-08d6244a13f1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4754;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;3:VcbWLaOiauju1Z8BDn74/6njVdHY0hLJf9z0Z6zNn2fMawbCZDWwSfNkcg0g9XZ7c2w/PqHROUQuA2GYSiE9s/Rnt7HGqrY4S0hihTQRtuACV0YrtiLALZBtGNGpK3dXhpx5bvvbzOHQa6TAAdjLmJn3pLaX1NoJIGc2cgNUPCpbA+DubPGHs0oQ+6TEVLF2oywuDXjb0L041IoauEk6erD5s8JfQvJGziFhlLIyC5cl7ZwHTnQEZdOKsAIHn0iwERwjwHAPyL99g3MuibeNxkzfXXunH8VAC58kriB3oSrEsY64xXsW8nQhDJRYKSmqF5GBSI6dEp8TLtulJMF4FOC6pG76ynQruFKD+Lx8YUI=;25:C+iezZEEX9LgzwnzODqiJ54OI+6o3ky8/lOjg4KiMC6bnU5FRUDROETaJad/I3qidZ7l2DwesIWJvm/crw5UY5uM9tziZlCzgHs0wc+AP3m871eRAzKADKu6ixPMgyy/TSlvXqzd6rK3OYH7TYLwEzYvIA8+eGqCPgoWXkBx1JQVQJVYyznxUkct8lMyBXF62G+9O0GG1er1F5wd2jhqb22Dv/4/bwPAoHtewuHZYsRMOtDyJIdewrTkx8Tw8fuiTqi1CuZ83RM4hB4P83gPoVlJdXp5CWfpSwPdA4eg1Aj1MuIQtxLdQ7s3LcdiM2lkn1WGDOCj4SiFFk4zyzo9ag==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4754:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;31:BYsXhgfGfe+JowUHKn4Ag4owGA2dcBRwZcb3QDzvT4xns5w8X2JPoD2KkjtW8kS5JhxQZD5JsmYaVmKVEBhvj8vBsJMjHGq+pfUbH3TlKB8js84ihWJWklPN9tNvDoSN6PsR9/lfTco98Gk7vMs8kMnSlqSfaHha5xxwRcTuN/K3HSfohi57Zx8fcC+rStZFT6Qysf/6PzQaDwvK2m8Wndf8PYFTS09Sy6WNuWFC1HE=;20:tqraejO6nS4FPP1ZLWmJXdZEr/zF5lJq+X1Jry/IzVKyMVWBXbDyvX1bytQzmLVzKuV3SHIFHHdQnR7+wbrgJuNhmJkCxwDGFAVpmBuLKSSDfOK9lxMcd73iXIH6b5lWz9DjGDeoUmLVhGO/RcNW3Dh/CTrmR+mMhjpvgWbhqyQbhbGcMyJ+52525irbfpf+tvlRy/3d6dj0NBAXDV15JTFf4ybCgIpz8I/QT2dWCXiU8HEDJ8mihK1HKasZvVdYvqbCy7TiUwe/q6D9tMS/uP2J9+1LDHibkjy4iOYfcNko4nzjiJy1Nf82xV59v4VKpjWCmOHcWh9ubLvoF608ECFeXmOXOC/4lvTy0wJPermHW/QD5l1RR72KI7EX4hX0/Q2MtW4xP70T8ZXNYbzkQh+ZiWU6OQDBYYUMeW367GElFzx6g785XZiSGKM4Ot0Q1mTUQ2UOzfXgv7QA1xcZDX+zvk8DuOQFWiTNG0wCOniY7kev0dH48Pf7e/SnW+vb
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4754C14524FFB4AB41F5F0E4C6140@BL0PR02MB4754.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:BL0PR02MB4754;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4754;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;4:3MTMq2ZMIgv8pSk6YDAKf0AH8GBnPDJbVa0w2iNwDF9xZCB9Azk5RnYqrsfAM4CJAnQha7yDDu36l8zkqPKMSnc0rWnjY7W4gVe1WeISTlciYWH82yYdyDAEEa3xsTmw3dYRmDgZOVY74fOp9lCjtR7q3AbNVpf/TvWuDXxp/icG1fIqMJ/DK9rpEBb6vOxBo8wskDQIyn9B3n92noS6wkL+LLpuvK61tmA/UcqmwS48fye1B0oV2ba7MYp32dndYYMzcYrl2+Vu0LIMcJbm1SZtuMVyk74yXMo7paMc1IVsJZCFXQFEz7tgVtIxl20c
X-Forefront-PRVS: 0808323E97
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjAyTUI0NzU0OzIzOnkzWEU1U2crSEYwODVoT3VtMkV2Vit0bVZW?=
 =?utf-8?B?Sy93bjZmd3RudjJzMGRCaUR0NGZ3V3BJdGkyYm5wc0lYbDlWeGY4dWVYSHJW?=
 =?utf-8?B?SmlJMmJYamxTUlJmamgxUXhhVTFaeGpBc0xyWTJFd29PNVpneUR3aVBFVnhV?=
 =?utf-8?B?ZXZwQWpiWkZOWFBBQzFXS0lPekk1eUVHK2ZvNkpscDY5SFZ2MkplUDFXMzh4?=
 =?utf-8?B?UDRaY2ZodFhDdUE2MXcwVHlldFFjSWZUNEFDVGRYZW9mcW4vNXozTUU4VnU0?=
 =?utf-8?B?ekJiM09ld1NMbGVKMVI0NUM2T3c5azZvSlVMdi9vd0hscDhOYk9zcThEam1j?=
 =?utf-8?B?MWJZNWJqb0RNdUN5MHdIZDdkNWRGYW9VMjY4UlVnSE8xdmFwQVdma0E2YXdo?=
 =?utf-8?B?dEVzSkJNY0UxY0FSays4SmZ2bHd4TmUyNE91WmFmMU41RHBUME5Jazdsck5P?=
 =?utf-8?B?VmhLalN1aklCYWpDNERnMTN6ZnFDYmZ2aTgzZmRwYzBhcEYzQ1FscDVuNzFx?=
 =?utf-8?B?eElJbUtjTE1EeExlSlNqNzJiTHRadStYbEFhYmFTalRiRWc0MWdzVjVLYkpX?=
 =?utf-8?B?OGtEUWh1US9sczhwWTVkM3NhWCsrd2VlcC95RnZ2Rm5HVE01Nk4yTmFGRFhE?=
 =?utf-8?B?VDBoK1RuZW9nRytKUXpSSVZYOGVqS0piVlR6SnRlWCtzMHMwMk5qOHN6cjlR?=
 =?utf-8?B?WUUrMUtuVFl3REJSV25laWY0eWZRVFVZY0hTZnpOMUJ2ajZyVUcyMkNsb2Qv?=
 =?utf-8?B?K0JnVUxxZjlwUks5dTlIQUhIL3A2akhsVjJZKzdqdTNjQ3Z6V2NaQ1Q2L05z?=
 =?utf-8?B?NkEvRnBFbUN1M3BNSVpneXk1Qm0yZmlvMElkYXh4Vk9Nd25DcHh4clRBSktT?=
 =?utf-8?B?RWNMaUdJeUFPSGhVWVRheXA0SituMHd1YTUydG9KSXZFMXZweHZVUFB5RXV5?=
 =?utf-8?B?dWZGbVltVXlhTTZFdytvSWFISFJWMXVXeDBvc3c3YmVpQ2d6ZmFlRnJUZVI1?=
 =?utf-8?B?dmpsU0dPMERIVTlhcW5lNTg1bTVrN2xHcHM4ajNsU1Y5T0RUOU01T003NlM5?=
 =?utf-8?B?QXJSeUVMVVpLamlGUTNXYUsrdjhSYmNvZlJpcmVNQ3U5Y2sxRFFYbzN4N3Zq?=
 =?utf-8?B?dGNvS2dJOC9CZksvWEJjOGFMcGthbHRyR1krMTJkWVQ3R1ZWallRbmFzdFA4?=
 =?utf-8?B?QkpVNXI5a05nNVR1QlY0ZGtQaS9uUGhyeHRzR3N0VjE0ZDdLMUQ0RmRMeklQ?=
 =?utf-8?B?LytDQjN2M3daZFhVaWVjUTUxTWxsY0VPcXZXME5yMW1kMEsxN09mZHQxOW5s?=
 =?utf-8?B?M0lJa0xPTDVVTHRpSGY3RmU4SE40bFJKdG5aendJWUREdm9XNGZPWFBlQW94?=
 =?utf-8?B?NUJYdnhvUEw3Z0J1NzJ0ZmJQRU9vQXd3VWlEY3cxT0gvUGx5bDhUNDFMdTg1?=
 =?utf-8?B?cHJJZmpHWmRSdFpBZm1SeVZ3WlkrRk5oTnQvenB1S1dhdUJRdXd2RnlLTHdQ?=
 =?utf-8?B?K3o2K3VTOENTalp3NXBSMlVHSzJqWnBpdDM5RktTckRzbEFjMGZPTzFUZ2h3?=
 =?utf-8?B?NkRFc0RYZ2puS20yK3U4VDRWUzJvZi9ZbnJxb0xiTHRlSlpVOVdrRmQ5ZFFV?=
 =?utf-8?B?ZDRiUmdRbUoyMkkwVlNiTEIyRU1MNmRRTDJ3LzdUWnBhYTljQ3Npa1UrUTNk?=
 =?utf-8?B?OWV2bCt2MkZ5T05jK01EOTVOOG5PdGxJckJWY3pYN3orSTU1SVd5ZUd6Kzc3?=
 =?utf-8?B?bmVzRnc1VUxDZVZ1dEZhb3FnT3ovUXQ3UE1YMUN1QkpMcERteGJhUEF2N2xS?=
 =?utf-8?B?dCtjdFF5S0ZVZ0p6bUduSVBJdnVFTkRTOGFhdnBQRUMzYVZyNnh6dWk1K0N2?=
 =?utf-8?Q?jzsF4+Eco57UgmEI/Tj+RsDnbyjLSxyZ?=
X-Microsoft-Antispam-Message-Info: jQ3oQ5CPrmKLhVbiRv6dRH0mPe+98hIgsnIUQOGVGLoIOYaPjqlmKzBMdIt8hGvMEq1tvzfmRdlQdK5oNs1TUkjPAz4YwJ52JYD4nQz1AnwtXjfM8Q6CqOwVkLH2TP1MV9W6vIiwRbnNAgVA0AqjiC76vlWd9phZP2BoV4iF+pHMoyTNasGnYjP/J1gZd2RoKTkYtmwCQPsycF007Hwgp+OWakNck8UmD33JqMtQTSShn+D96NiVh2D4/Xn44i/nUpRWQwwUdmbloKA+jTf1ZZEFEUHu3R0NzPxcrr9wJ79ZE+eXxa33ROvO9k63GF/ByA/eb5MBESOkAfrWNy66N3Jt4mmg4QWomC13GMKkkQQ=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;6:DlsQ13Y/x+urZ6AdAHSOJGJ+3HZCVYXo0ioo+prfML6YyfTCH+YYxd+Xb7SjOgEUQHSkfsXT4bjb5IAfRa/TLhxhMYj3RBK11TsKv7oGX7r4bgaq2tXcgt06+VqVP71Ynx2aNx0hHuSIvASPdRp/EeAI3bMs5cqFR5rFas9OBfA2Btjt2d4SJcZ225qfdU68OXb4RDyvXBVTVLBV9F81ymYsVRJSkxShkJVjLEIR2XlhakkCLVO0hL5YcdtwzGeV360vJO/q3FGeSireybVMjB9djvPS9wAVkOpzso2Nkl4EAz1kfrfTXs1fWL/tiDZ8CJGhM4ITzzECbeQ9M6WEOHWqNdDn8exrmKM0nWrBB+2PA1gd4IvqTqu9XPYg+116sCNnvdRJVb98lXpH8vRjIyARP3c4QdaU8JvejiuS19pxj1od1JDB3EpFCNWqPaHyBcMNWE5cUvSwbti9DdHCIg==;5:JBdra0hdtEuhzittQKN9t66kjI6pHbfNmlxGU7/ocwATm25PxQXzrNnMrcoC9Rhz9z1vknHyZu+MwOT9VMhSrwkyLVeyVvglBut3g7sFsHWAjixoeUGg5cepYMM/Fp+G/peMQfY1th+EEBLUYfcKHAE4xtECiZ3yY9PiusoOdqY=;7:PEXO+2BVJLiJAW/yocb1YH2B3gy7Wmdt0aKiygY01sqHNzppXIwQPKZVRG191YcCOGI56gc7LCqepuZ3KxHbYk4qsehn6U1DM3HDxCKLtHDJJA8Bp59bqbIjVuvI/2ZYIIo1qPKP71kZP/S+akiikvoioqM9RMvK4R0lgZofTeu3CSdBHPxoCQ/oju7kCeMavHqa4fzWA8J2y3m3cZQQQNZS1br7m+ps4+RDTOuAC/JygA+H+YauXBcYb0fy4CAs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2018 07:23:09.7788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d058b46c-0c33-4901-aa00-08d6244a13f1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.9.2018 09:19, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> On Wed, Sep 26, 2018 at 1:01 PM Michal Simek <michal.simek@xilinx.com> wrote:
>> On 24.9.2018 09:41, Geert Uytterhoeven wrote:
>>> On Thu, Sep 20, 2018 at 1:42 PM Michal Simek <michal.simek@xilinx.com> wrote:
>>>> The function travels the lookup table to record alias ids for the given
>>>> device match structures and alias stem.
>>>> This function will be used by serial drivers to check if requested alias
>>>> is allocated or free to use.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>
>>> I know this has already been applied, it just drew my attention.
>>>
>>>> --- a/drivers/of/base.c
>>>> +++ b/drivers/of/base.c
>>>> @@ -16,6 +16,7 @@
>>>>
>>>>  #define pr_fmt(fmt)    "OF: " fmt
>>>>
>>>> +#include <linux/bitmap.h>
>>>>  #include <linux/console.h>
>>>>  #include <linux/ctype.h>
>>>>  #include <linux/cpu.h>
>>>> @@ -1943,6 +1944,57 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>>>>  EXPORT_SYMBOL_GPL(of_alias_get_id);
>>>>
>>>>  /**
>>>> + * of_alias_get_alias_list - Get alias list for the given device driver
>>>> + * @matches:   Array of OF device match structures to search in
>>>> + * @stem:      Alias stem of the given device_node
>>>> + * @bitmap:    Bitmap field pointer
>>>> + * @nbits:     Maximum number of alias ID which can be recorded it bitmap
>>>
>>> IDs
>>>
>>>> + *
>>>> + * The function travels the lookup table to record alias ids for the given
>>>> + * device match structures and alias stem.
>>>> + *
>>>> + * Return:     0 or -ENOSYS when !CONFIG_OF
>>>> + */
>>>> +int of_alias_get_alias_list(const struct of_device_id *matches,
>>>> +                            const char *stem, unsigned long *bitmap,
>>>> +                            unsigned int nbits)
>>>> +{
>>>> +       struct alias_prop *app;
>>>> +
>>>> +       /* Zero bitmap field to make sure that all the time it is clean */
>>>> +       bitmap_zero(bitmap, nbits);
>>>> +
>>>> +       mutex_lock(&of_mutex);
>>>> +       pr_debug("%s: Looking for stem: %s\n", __func__, stem);
>>>> +       list_for_each_entry(app, &aliases_lookup, link) {
>>>> +               pr_debug("%s: stem: %s, id: %d\n",
>>>> +                        __func__, app->stem, app->id);
>>>> +
>>>> +               if (strcmp(app->stem, stem) != 0) {
>>>> +                       pr_debug("%s: stem comparison doesn't passed %s\n",
>>>
>>> didn't pass?
>>>
>>>> +                                __func__, app->stem);
>>>> +                       continue;
>>>> +               }
>>>> +
>>>> +               if (app->id >= nbits) {
>>>> +                       pr_debug("%s: ID %d greater then bitmap field %d\n",
>>>
>>> than
>>> %u for unsigned int
>>
>> I won't fix this now because this can be done together with one change
>> described below.
>>
>>>
>>>> +                               __func__, app->id, nbits);
>>>> +                       continue;
>>>
>>> Shouldn't this return an error, if of_match_node() below would have matched?
>>
>> IIRC Above check is for "serial" name.
>> This one is for getting XX number from alias "serialXX".
>> And below is checking compatible string.
>>
>> You are calling this function from uartps with 32 lines limit and there
>> is serial33 alias poiting to uartlite (for example) then you don't want
>> to break this call for that.
>>
>> What can be done is that compatible string is checked first and if this
>> passed then ids are check and error can be returned or bit sets.
> 
> That's what I meant: currently any serialN with N >= nbits is ignored, even
> if the alias applies to the driver that called the function.

ok. Let me create a patch and check compatible string first and then
setup bit or fail if N >= nbits.

Thanks,
Michal
