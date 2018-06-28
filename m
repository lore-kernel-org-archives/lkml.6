Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E41C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDF127029
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="z6w/P08m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDF127029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964930AbeF1HSb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:18:31 -0400
Received: from mail-sn1nam01on0062.outbound.protection.outlook.com ([104.47.32.62]:49328
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753657AbeF1HS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy4NAAr0i9PQhzBDZY6x9J8FQomsZNBbuHH2jdNE98g=;
 b=z6w/P08mr4JItKoyUtxW/O+I93Rn0kB3P77QlpmE1lD2mdnsuGIWHYOCbY4LucHauDg7JntXLrY+A0AOzbF7FsawIiOXeXbfDq0MqKEG+l4Z5z7IWBz2WxKkm4YRqXkyfhBOnNqMFCZxunSr0g3OkNaBLk4vIHLy0W6wUDh16Xk=
Received: from MWHPR02CA0055.namprd02.prod.outlook.com (2603:10b6:301:60::44)
 by CY4PR02MB2648.namprd02.prod.outlook.com (2603:10b6:903:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Thu, 28 Jun
 2018 07:18:24 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by MWHPR02CA0055.outlook.office365.com
 (2603:10b6:301:60::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.23 via Frontend
 Transport; Thu, 28 Jun 2018 07:18:23 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 07:18:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fYRCA-0003TO-NF; Thu, 28 Jun 2018 00:18:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fYRC5-0004on-HU; Thu, 28 Jun 2018 00:18:17 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5S7ICZd013284;
        Thu, 28 Jun 2018 00:18:12 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fYRC0-0004o3-4b; Thu, 28 Jun 2018 00:18:12 -0700
Subject: Re: [RFC PATCH v2 1/6] serial: uartps: Do not initialize field to
 zero again
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Michal Simek <monstr@monstr.eu>, <linux-kernel@vger.kernel.org>,
        <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>,
        <shubhraj@xilinx.com>, <robh@kernel.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1528288895.git.michal.simek@xilinx.com>
 <e8b0169887855a5ef2c1a0456842f650601b451c.1528288895.git.michal.simek@xilinx.com>
 <e7b01bd9-5763-75c0-1384-2536313f5854@monstr.eu>
 <20180627100917.GA20940@kroah.com>
 <05e553c2-202b-0b4b-8b88-60e330c80fa3@xilinx.com>
 <20180627234836.GA1691@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a12639be-dd7b-d706-9c2e-35a99b816383@xilinx.com>
Date:   Thu, 28 Jun 2018 09:18:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627234836.GA1691@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(2980300002)(438002)(189003)(199004)(5660300001)(356003)(81166006)(486006)(446003)(54906003)(6246003)(11346002)(126002)(106466001)(2486003)(63266004)(23676004)(4326008)(44832011)(76176011)(476003)(93886005)(478600001)(65826007)(305945005)(2616005)(8936002)(64126003)(81156014)(36756003)(58126008)(106002)(8676002)(316002)(6666003)(110136005)(230700001)(31696002)(26005)(77096007)(47776003)(14444005)(9786002)(186003)(2906002)(50466002)(336012)(53546011)(65806001)(31686004)(36386004)(65956001)(426003)(229853002)(107986001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2648;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT053;1:fP1OnnvZw7QEHv3a1ENdhkJUzyS5YduOTsiK08MkoKYspNHbGFkINAv0R5tf+yxY+EKXrSD6245V6suYRI9EMeSI4I7jwW70hEosUT9E1VYJtcKCGcoDJ+D4KFcVyBaR
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 121d8556-90fb-49d3-78ed-08d5dcc755b9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR02MB2648;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2648;3:EeN/XLAcBQ/xYnofv0is5z1Ql0Vw2FgRUJK+1IIEVQJ6F5eRZJFoDWME+7B3HjRxT+2t24jP22LzUTk+Vc8jEWqI+aaWGGbzHCvAg5xIPz2c+9TMT2EwPBx+n7b2iVXkZFrztzG3Etg95pSz3GBYoVjyx3ofhdnUxGYgbZSt5eaKzMdZHiQw5RAPiUI32wsJc5vWCsE+jhy5BCvFuD2VLwB0tRXdrCMr+rd96/7FdGzRz8jwhAQxmIX6WN9Gjd/bG2YazfMWBbZ9mOhAK06yowJASCfKhx1NnN3Jyzjw2snynDTrh4Z4BdZG3YIoG+YO/8INwuOZ+0tXKDYkIEXFk74ZjhRzg2QEJ5hF1eAYWaA=;25://ZA5QDxTzXycbO4H2vWJtZ9rYGX3rmW0buJ3LbHpMZxOj/NXjQ5wumE4UQjuXmlgD/C1l5jn8bIZE7MHy/Ky6JMd4oNX3BygDDBVV9kOFL3Ig7PBC/IJUPu0s7qsPstNhOBFF+raNQ/J7TbgGcXOyikZfO56998Wjs1zmsCZMPMd9beGtOEbzUHMrjx5s8HBz8ZRVREbDdIhq3KSiYfVOxcrNOXdMpWZ7eEXPBpO12ueF+gXtZcOZFthMHYpqaTDUPBLExN1raZHKeidr7U4aF5mBUSf4fMnOjFLcFMHgm4HZYo0VrxS4O5WW/+3AYl4/Wz4a3MkNNbv+e417CarQ==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2648:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2648;31:QjSe7BmC3fv11OLNIysqWE2eHysqzhtNQKXPA4CCp2xsKYuajRYSDdPMfN8t0/oMDa6odgOWUZCbrYX428++maOiGo1wRupQKKUqUyEpTWZJa4OyghxjM33U3u4cl6as1q5q1mrvoP2E+9690UQfFZlsN6G6Vcury9pAkcBFp/ffttnEbi2CTWotQDSsVS0El3KBKCruE6PgxZANLtCSbmqzOVEMe1hlIITJgXNo9+4=;20:CIkJHvRXHbBLrYVstHVUTFBLTI+QNw2/0R3sS/j5vCUpyKeDKe3ELW9h8/Eu5bzcUMnzQzOo5OWL86b+9Cs8axcvrmglOug3tPe2EOA2e4Qd21BNLcHzf6ox+mIw56/biPwTVVw/BBNRKYewIH9XVf1xqLUWVu0OKb4AJ2xRC2VwWzCvra1hr84T8tjmIhqDt+9C4Ab/7d+Qt/jzQQCGvb7g6vr9RWBFL2kTxu7nH18ncpByHBjhktUZUbj+a29225iAZ2XE4qBtp8DP+nXZ/WKboJYKr8Ahr62NJG1QgE4cx89ip3kjscMFndL8Z8NRkl1dm0fxSgQ7X0Ban70f2qHoaB2zr8q2kRw142z+EzYOSwkU25GEVLflPGCq3zdBHftT4Gx1/AQ4xgWQWbsnivzt+qP/GqolJhw6xQZZEAFxgjFK6yHAS44+2WhCSj3TeKhwh5q3Et3xxDG9i9aijZH0f15oIKdJhunOz6tN9jVQPXDYMnZnZQbliQJaqP2y
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB2648DBD6848189CE949BEF36C64F0@CY4PR02MB2648.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR02MB2648;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2648;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2648;4:SNHee3/A2xX+io+4ftGXQ1+98FshYnYddQLyewranoCwsGqnUsoNw3Td6BxtSZT5w4dI2t1nsqXXGxFiuq3r9JY9h7BAk750EBQoMbwXI0UikXH/R9EcQgmpvfNcyheTt3elx/rmQwXiFsxXTxzPK0YIFx6uKZLf8HZhS0vbupUSRCjR7LLWjaQvcVpWK3lR1fA1HXcd0s4e+p1QbMMzJGPG/hsTsKvz/XWOABbjy4Kx0Ur+CUEcHj6U3Jrcutb0Dxujq3TBVac6HxsB3RbdZRpaY5AeVKU4gKk74Un8Ul29HQh56XVoxmJpyrDzP481
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjAyTUIyNjQ4OzIzOmFqMW9EdmNLWlpWcUp5R1g5U1BzTVhoc3kx?=
 =?utf-8?B?M29YdTY0L0JRdzlPWDlISlowbkJ5WmdnbUg2U0ZlaW1BdTJLcm1OVlFQRFdB?=
 =?utf-8?B?aFhOd1BCSkFIb3ZGS3pPR2pFa3doK0JiOVkwUVQyMEVSSGpOaDI4eFlYalBW?=
 =?utf-8?B?bUY1TnhlK1ZnSnhHdXdjOXpBaGlLTTVGbTFkOEEvTUtqL2w0QmMxWkN0c1ZH?=
 =?utf-8?B?TTNHYWVXREI1L1JiZDFWRHJGcDl5Z3czQVppN0x5S2R6WVN2T2VPUzNsVVBB?=
 =?utf-8?B?U2kzSkRiaFM1eGd2S3Z2enBvYTJwUFpoTlVYNU5iNmNGNVVPRitTaXBmK2Vv?=
 =?utf-8?B?Tm5HN1ZsUmZ4eWJWMGV1aHlQYWRkdWc0bDdnN0RwQktjVGN4YzFiN2V1MWp0?=
 =?utf-8?B?YW9HVldxQzJGNlJKc2FWdWJQeHUxV0prVVRLOHYxblZMcnJWc0dVVnZHeDdK?=
 =?utf-8?B?N1RGaU5GeWZ0MWxTSUFmeHVRWlExRml3ZE5jK0JiK2M4R3F3Vk5ZUnpFWUIw?=
 =?utf-8?B?ZFZrMU9qMmVTcG5zQXUycXJuZ2x4TlZDZWtVcDMwRTJTbmxuMmEvWENSYWxQ?=
 =?utf-8?B?T05keGZDYmRGVTZPUWF2cmp1UVdTYXVSV2pLOXVjcmlFaS9vTzVTSjNYWGx0?=
 =?utf-8?B?SjVsM3lIMFBlYlI0MmhHTHVjalBVSlJoVHU0MHd0T3ZWeFNVcVcyRm5jbTMv?=
 =?utf-8?B?TnZXcDdmUFNQbWVPYVV3UEpadnNLaExPQ0dGNVlBUjA4elZQMTFwMVdWNGdz?=
 =?utf-8?B?T0xleHVVRnZWa2IvbTNrL3JIMU1uZmEwQ1FsVTlpRDJjbDhhSTN2ZUx5Tk9s?=
 =?utf-8?B?WjhUU0VnSVFGZUNQZjdMWmNXb3N6c0xjd25hMlBsc0VuNTQ4N0FEdm13ZXhG?=
 =?utf-8?B?VjBDVFRYRWduVjV5aDhlSVZoY2RnZm9NUHMrTVdxdzA4SmYrZDdlaFRlL05n?=
 =?utf-8?B?bGJZbDdvcCtiRkMrN0Z2T1RqWmpSd2VHdmZ5WmZoOHloOWxMbk1lejgwMmZD?=
 =?utf-8?B?OGoxankyVzRPYkQ2UytwbWxqblZQdVkyL00xejFubzhWbEFSSkhDUXIyTGtU?=
 =?utf-8?B?KzgvU0s4RGJoTzlRSjhva0xiWG5HUnJVYmZSZ3hwdXBGWGNCZnFYLzd0QVNk?=
 =?utf-8?B?Q3ZGblVwVE41UDdTOVdnbWNNTVA4VGZzZFIzazhrYS93V0FsVjFiUmFyZkZI?=
 =?utf-8?B?cFNMRFVYbzZicWVHM1U2UUlrVXZGdG1RSnF0ZU4zRzg1ZDJtWjErNk1odGI2?=
 =?utf-8?B?S0RBd24zWjFDQTIxZE94K2JWYUhFNis1cVRRSDBHNVNhQ2JFSWIyVGE2cnhJ?=
 =?utf-8?B?Q1dVcVJVYzNhcXRJeWZERWQ4MGxHTnk5MzZtS1NKTmg1dWFMQjNGRXBGL0lw?=
 =?utf-8?B?dVZSTlEramZHMFVNbEg5amxuc2ZwMys0alJPV3pSbm5NWk5aamFyODRPUmNQ?=
 =?utf-8?B?d1JUMEwvclVpVnFOcGZ5Y0JRc2ZscjlrdUwxMTFiL2ZzRDArUlV3MnhZUkFQ?=
 =?utf-8?B?MENEM09qR0xjMURPQitmQW10Z1lyeDJqYmlLV1RBVVQxUlN0VE4wRmRCa0JO?=
 =?utf-8?B?UnVWZUJmZGtJYjg4UFJjVEtFRDZhL0dGakZ0cCtoYWJIWm9TZERNYnpKMklM?=
 =?utf-8?B?eUVFamljMkMzcjFlaHh2VjVvbGZTTUtrUExOYlkwZkhnajdLU2xFa0JkL0tQ?=
 =?utf-8?B?WkJIOGFSWGpMMk82emF3Ukh2SnBxMW9DU2t5dnFEKzJZa3Y5RTVJSUNiQmpL?=
 =?utf-8?B?dTlDNVBlZFNBYVpCdmlpZUdFK0ZWdFRJVGNQb1BWM0ZsUmpDOXFvYTAxVDFS?=
 =?utf-8?Q?S4ZH7SRww8nCH?=
X-Microsoft-Antispam-Message-Info: Mg2dgsMVo3tmeFHLdbsq3EH/b0eoymjREbHuJlT581IBmpewrrLOUz64WmYsZ5HyQxKvNrQVQ3IxOhaCb5VQ/6HThL3JX1VGzN80eWvtWak7Lnq2xhoKJtmmLJPds9EhiOYUGQ8g09BHVpre6FKcfli6ldOUHkEbftCQZ/74RxLcZpd6dgXiPO+/Bvp1y1vDf6IZiWQIvRr4HWR2Hz4R8IaTyix7L/XjSv84slopxpirWSNndHjM4LOj/zA4p8M1DLJ4xMkdOlOc4Wd4yGOBMeLAC9ASIc3qV9j3F1qDhB61NmgxFSrDjdAqRX7MmJVhAjE+Y8R7YyLeSwC5Uc7arCZWEegdmXJDeB6tupz7hWk=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2648;6:gR+WAm60eNLiy8F5D1/l/+CCMIO3CUfphA3+sfqFF4ygbl+Fgl4u1Xw3hhocPyhPpE+2qbTnoviY5daBShJaMohPvSbviA4jNL7+Y4q2X3xVGyznsNGXDcCOdWcpsJ0aGnpbWwuQYg6sCWLkf1JbWeqQctoKHzWwLrRH8sDp/ij2SmZ66sEDoQdy56zVakyxwnqGOISfqcB6yZoYjP+FerGTbBWPnpUXbcd60fJHBtF7D5uYyxfy5M1UyPZgTqeEnj6zXNXgNMv3gqhB+aJDTk6GXhww3EnspIo9AOS1wVCRr2fw4y083ocfEqZ3WQx5HwFpCbYxHnCQafp+q/DH8y76As/7WAG9NtQI61Odr/SVVtvSwMg0jLkozAENhkmUKSNNdMOqih6a4XjXmT6rOu2hpAEU/vN2wKtQuz8nuJlKJlRKODfderNlpxqikU+7LDj0ND4hzsJoAMrmyulkPw==;5:ujoPqB8QP+PTNNylXYAe72rbrsKi3NaXOsam8ISz3q0BGVjoddPdAhxnQz8/QwZ4QrpKda1LYd+/DzZSbu2fTUEqCLnVVS5O7m3lFHA2s5mzNqJu+MubZHo8uTgQA7zXvs1vAttV0F6YsZaAKHyUQhROTZgbHjPbLBaCti5LUHY=;24:MJsLXrutpDgiO4hD/gdLbpUYM5odKeSiIbKnXmSVsJHXmswOdMIfFOU0Vfc76hhiuF45COp3dtDrwmqtAhdkAh+heRzeft26eKHxaGEnXM8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2648;7:ovcMMZMFA/NGOa8AuRfLJa/3Yn17aQhPtd+/HtKc7hPR/JOgq2317Mg0qk2+rXfgXDwqbfOCueEzZbHSUEl1cPoPjeGirQU+xZZV8r1PXtlmSZwQkmOslRN11PJPOA1Q15KYZLJNJu0T6cXhRpS0wuaODukD1KOAPwGOpZRrU9J+bmVae5o3HAuFrUrXPY872czfBkh0Mr4H/lKOKfqWT+q/33KhuAoIgsOr6ejqHlNO0KOUW78YLLG0CWBnnanX
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 07:18:23.3551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121d8556-90fb-49d3-78ed-08d5dcc755b9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.6.2018 01:48, Greg Kroah-Hartman wrote:
> On Wed, Jun 27, 2018 at 04:19:46PM +0200, Michal Simek wrote:
>> On 27.6.2018 12:09, Greg Kroah-Hartman wrote:
>>> On Tue, Jun 19, 2018 at 10:09:05AM +0200, Michal Simek wrote:
>>>> On 6.6.2018 14:41, Michal Simek wrote:
>>>>> Writing zero and NULLs to already initialized fields is not needed.
>>>>> Remove this additional writes.
>>>>>
>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>> - new patch - it can be sent separately too
>>>>>
>>>>>  drivers/tty/serial/xilinx_uartps.c | 3 ---
>>>>>  1 file changed, 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
>>>>> index 8a3e34234e98..5f116f3ecd4a 100644
>>>>> --- a/drivers/tty/serial/xilinx_uartps.c
>>>>> +++ b/drivers/tty/serial/xilinx_uartps.c
>>>>> @@ -1510,15 +1510,12 @@ static int cdns_uart_probe(struct platform_device *pdev)
>>>>>  
>>>>>  	/* At this point, we've got an empty uart_port struct, initialize it */
>>>>>  	spin_lock_init(&port->lock);
>>>>> -	port->membase	= NULL;
>>>>> -	port->irq	= 0;
>>>>>  	port->type	= PORT_UNKNOWN;
>>>>>  	port->iotype	= UPIO_MEM32;
>>>>>  	port->flags	= UPF_BOOT_AUTOCONF;
>>>>>  	port->ops	= &cdns_uart_ops;
>>>>>  	port->fifosize	= CDNS_UART_FIFO_SIZE;
>>>>>  	port->line	= id;
>>>>> -	port->dev	= NULL;
>>>>>  
>>>>>  	/*
>>>>>  	 * Register the port.
>>>>>
>>>>
>>>> Alan, Rob, Greg: Any comment about this RFC?
>>>
>>> I rarely review RFC patchesets as obviously you don't think it is good
>>> enough to be submitted "for real" :)
>>
>> There is one missing minor part but I want to review concept first
>> because I didn't find any driver which is using this style.
>>
>>> If you think this is all good, great, please resend it without the RFC
>>> and it will end up in my queue.
>>
>> I will definitely do it but please look at the concept itself because I
>> would like to use this with at least 3 other drivers.
> 
> I don't have the time right now to review "concepts", sorry.

Ok. I will revup that missing part to get it review to be able to use it.

Thanks,
Michal

