Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94255C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3606E21934
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EtL8V4C/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3606E21934
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965112AbeF0OUJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:20:09 -0400
Received: from mail-eopbgr700069.outbound.protection.outlook.com ([40.107.70.69]:57668
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932579AbeF0OUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq5H/XFrK6DOk1ZCHfedND0bh/7Ru52tf69NmKKOX+o=;
 b=EtL8V4C/AhSIB8GISEx4W1exOxSaMPOR3A/HncHtMIxIGiNuCa/c1FUakXF1BlevR3M8pqq26Bs+CpCQBkYmFCQtDJBZ+hX3Lf8MIWmT39ZUMvx6NEhrjcu8WZsHEDiMbccR+FcCrU/orOYB1amiCjrRwlhxPzhhIMvzpQfNouw=
Received: from CY4PR02CA0029.namprd02.prod.outlook.com (2603:10b6:903:117::15)
 by DM5PR02MB2649.namprd02.prod.outlook.com (2603:10b6:3:41::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.22; Wed, 27 Jun
 2018 14:20:03 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by CY4PR02CA0029.outlook.office365.com
 (2603:10b6:903:117::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.20 via Frontend
 Transport; Wed, 27 Jun 2018 14:20:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Wed, 27 Jun 2018 14:20:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:37388 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fYBIg-00078V-FP; Wed, 27 Jun 2018 07:20:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fYBIb-0007jC-BR; Wed, 27 Jun 2018 07:19:57 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5REJnnb028235;
        Wed, 27 Jun 2018 07:19:49 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fYBIT-0007ia-Gy; Wed, 27 Jun 2018 07:19:49 -0700
Subject: Re: [RFC PATCH v2 1/6] serial: uartps: Do not initialize field to
 zero again
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <monstr@monstr.eu>
CC:     Michal Simek <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <gnomes@lxorguk.ukuu.org.uk>,
        Alexander Graf <agraf@suse.de>, <shubhraj@xilinx.com>,
        <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1528288895.git.michal.simek@xilinx.com>
 <e8b0169887855a5ef2c1a0456842f650601b451c.1528288895.git.michal.simek@xilinx.com>
 <e7b01bd9-5763-75c0-1384-2536313f5854@monstr.eu>
 <20180627100917.GA20940@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <05e553c2-202b-0b4b-8b88-60e330c80fa3@xilinx.com>
Date:   Wed, 27 Jun 2018 16:19:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627100917.GA20940@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(438002)(199004)(189003)(36756003)(230700001)(478600001)(356003)(65806001)(65956001)(336012)(47776003)(305945005)(50466002)(53546011)(2486003)(31696002)(14444005)(93886005)(126002)(186003)(316002)(476003)(486006)(23676004)(54906003)(26005)(110136005)(76176011)(44832011)(58126008)(77096007)(106002)(426003)(36386004)(4326008)(6666003)(5660300001)(9786002)(2616005)(446003)(11346002)(65826007)(6246003)(2906002)(63266004)(8936002)(31686004)(81156014)(8676002)(229853002)(81166006)(64126003)(106466001)(107986001)(217873001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2649;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT064;1:kH76m21eTLC4wpX1IAW62TXenvVEqKXA0MUEt5FiRlpweycJ9JLX3OmZ3FGPq6cBdEp7CW11DuO4ICvUIe+EGnytoHFafxpsiTBclo730WpNh20uKp3ozx3lLaVVbr/j
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f1a8410-a965-4292-91fc-08d5dc3912f5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR02MB2649;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2649;3:2e6We1oJ2IrL/fntfC6VyDVYBOMGSfUpRr6jPrN6vIWn8BK1fE2+yuSMexgBHzqoa7xHIE+/jVfaOA4z2/fD7pkn4FGToZdiezjHS2+CPUBxL/XOzmMVKtLTa+LLpr2r5c1wvs7esKSVPcJNPW82+vG939kRVIJomdY52rQhp2sUbLNcdOKilviasFrCtzQqAV51kdRZ3xi2D5AcmGILZgmNSHmjyNzJu+3M0eB+AOHJe0rmXO7bC9FW8+kUxOjghDjhyW7FQDQpx3lIhVI5tmxgLlBSah5NBu0grOc24S7ekclpgfPyoVXv4BK+SPcXtV2AfNDxP4s3KAwh3Y1vzWW0a3mqrz7TBIQaJtvLnVg=;25:+NDT9/Zqmhn7u9HNi3BfRJYlnjDmFHkhmF67IPoeOXxzcS7Ec3FLttf9Q76jJUCyqd7fQM/Sah86gqFOI56dNKjpxjO9jYUZgKukjdU5RvrMo9Cs8kur2mMoBIVA+f3zrdXn3BfNO2IdGJUG/Lsz+Yg6GK5UKOECuUVlqh+hhcq2lkRSKdIz1pBTYUBnLWf3TzyonTJFiI7iVQNaxtKch6/OBE/iTgrkEwq94Xpjl7Vuc7yovmQ5nec/Wo6mFAJ+MDOmcWZDXumFRcNcEG3yoV/o6eLi4A247ljOtaEnQBAVEDWNFLnty46H3xEnBoAJY1CCGBmnMJgSOETL+jFm2g==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2649:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2649;31:1B0KkhOha4Z95AtUK6W80QtC7dAn7tCuCaXAQg/gFAh1uE8CL7OqYrD5SIs6SS/+Bj/Hv2fGsinrwDoevAwkbX2oW/HMWsNcJg7s//Dv3zcRqL1FT91MwcxD2kC1rwWbhVnhe+Jeyt0jXzCfqkuO+H3bwkeAlYO8eO/8G5W8SjedezP5I62lpuVbZ74LU0CzO1nWSfJZSTVEvNPcenG2Jbka0sVVwCzYvB6ux3epx+o=;20:JVRAp6vvQsU/5zaTexFfpMGXjOsjEuUqYtyM0eY1UE65UI3oxdSq5z30AtSkKOrDDhB7rPO0ydaJ6RsKnNfFyAMOHnX56RNIYI+x2Fd7HGQK0B3BQLwdBnAOSu449oodh6Dkhm7XkKUlPczycWzlIrVQBPu8T/daMKGwxWI9kWeDhi3GB9hjEtrtE7JoatVaVWxf6XgyqMV28QpKO9PyUjbSeY/Gh0CazXjXg/ujI2lZvKhPZvICBr17XvsBy2LB3sMXyyIYbAk8gxsbnf6EAb1MbXXiNhPBh5MbINi2LZvI6d7zP7Zl6fJ3u0ovY4ToHG3EYX9PZf2yXE0UrI8XBcTkApiqUYK20EzVpvhuizgbcKdVlRxeHykYPlGfraoYkyUFFUgONkSEdU9ppdfKRCG6DaOsUlkRL0FCXkF1+YQVrDLatXjW80/Ku+Wk+jp291yHvCeTJKCYFWIy/XotUc7RXGdWLGIr8PdHcqCnRin5Hs9oIOpErccCNgr/+1Kq
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB26495E61DA6610763599D86EC6480@DM5PR02MB2649.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR02MB2649;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2649;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2649;4:rp8DnTBySTuO1MGEd46CPqJd0kfDe4+z7QyZT0jDTWIpM3URw0ysy8XEeHrBGGbUS3vlTj+OGjgpw2zLVeZ+yUJ4Klppp0QQ5ugtKsKXtEoFQ81y4EH/jCy03EkJkt1tumpsI1zBJp+MpqhGzBKEl2m71kKQiL2CroWWo8aO6c4PRq4hXTMS8rRaqCJgtyYh9r+Ih+4WP91Ln05SQoJ7TYWN7EdDJG2rTTWQj9SCnEBT0zyPuX+1tRkc+VU2gfxzEeqcbhHwVYVWCkQa4zfa2HVY6FTDg24W/oYGAGYL0p4ROFc3Zsr1Wn9QckZb+Azz
X-Forefront-PRVS: 0716E70AB6
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAyTUIyNjQ5OzIzOmNETmM3UTVwcHFqS3hETE8wKytDYUg2ZmJ5?=
 =?utf-8?B?ZEg4UTJWbisxSDVxQnF3YWZYSlhsQ3FDcVRDWjIxR0l6djNEcGFhRkFYZ0tT?=
 =?utf-8?B?djRad3VNODRPSGlyVVpjck5hdjMxWFNiRU1jVDU1N3Y2QjFlVFFkK05CamRG?=
 =?utf-8?B?N2pmS1QwRGl4akdsUGhSL3lROS9TREt2WUhrL1BRci9xclEydmpNenB5QzFC?=
 =?utf-8?B?VCtJYXRQQmt0S3pYWFR0U2UyRHJ6UWN5dnc3UitKZ0ZISEd5U3kyVzRKTmlU?=
 =?utf-8?B?LzUwK2NORVEvZkt5c0FoZ1hHN1VLanA3QjZwM0o4ajZLeVFVeC9vbCs2OWlB?=
 =?utf-8?B?R1VtTmZhaTVVcVZkOTVBc2h0aWp2Z3ZNclA3M0g1YXZ1Qzc1OWszZXZSZ2xM?=
 =?utf-8?B?TE1majVlR0krRlhYak9lSXVXbnZESEJpb1FoYnNyRExyU2lwUiswbVZlQ0lV?=
 =?utf-8?B?Q2tnVUlTQ0RqQ0hnaXFDclhTMEJYTWg4ZzJ2V1JrTXh3di9aOHRsNUJWVmFx?=
 =?utf-8?B?MVRVbER6aGxNVml6QWNoaUxKMSt3endkUzFaM2h5OWtrdkdGcjA5a3IvMmc2?=
 =?utf-8?B?MEJ4YU5TRFlQL3hyU1NWQkx0Sjd5dU11YzQ3Z2VNMlgrMHhoR2pkZDE3MlZp?=
 =?utf-8?B?WlU0NDc3cGxXNlNjajg5b3lKVnhmc1V1NzNUQUt3dllvU2tGUlNjZ1VYOHdM?=
 =?utf-8?B?RWtOZnZTR1puYlhOdElrQkZNQVJ6YkNEa1gwN2FkNGd3bW91MEtEd0prTnN4?=
 =?utf-8?B?dEFBZmZKMnVHVklXM2RhUmJoS1U5R2psMlArSWVZR1ZUdngrVEIxc2ZGV2Fi?=
 =?utf-8?B?c2pXNy8vVEtWWjFjbFA2RTJFNkdNbFB1YkJBeUFjYUdqWU1VTjZ0ejdBYkg4?=
 =?utf-8?B?ZzkrYXRiUVRzRFdhR0N3bDRSYzlocVdyZ0pvNW9Va1Q3L3dUN3NvVXJrRXRp?=
 =?utf-8?B?Z2lua3NBOTkxdE9IOVdoSlJ2RXEzUEN3VGpNeTBLdk9GLzY1cnpKMXBJV0Z2?=
 =?utf-8?B?YnBVbmkzSVVhY055MmlBMHhKYmZQOTZKRWw4WUpEaWpZR1dQOGtpNWFZZkpU?=
 =?utf-8?B?OG1vMXMxKzA0dDNsNE9YdFBBUmtQcmVwaEZDaFQvbFF1ak5vb2FFSTBYcEZt?=
 =?utf-8?B?c01peVcxbzk1ZzdOYXhheU92aXMwdGFLdVpxMmdFdnVqaFJLaXFmbjRIZU1u?=
 =?utf-8?B?cDVkT2FVV1JSVHdyREhyS014UkRuSGphc2JWVnZ0YUJzODBDUmY4OTJLU2lL?=
 =?utf-8?B?T2FGRVNqK0thaXphcTFhQjR0SGY0ZDdmYzV2WVZRZW1tWHNsOVFsdjJIM1Fs?=
 =?utf-8?B?dlZHOExqSGZxdlY0a2pWdSt0cnlVbDVGTTZ1KzA0RzFVdkJjNk84YVVLWmta?=
 =?utf-8?B?RXNuTHJVZjZEMTR4YWFPaE9zNGJibVZuQVdJc3M4MkVBYWNZNlRSbm9xaEk1?=
 =?utf-8?B?dEUvZXVoYzJaR3Y4WGZHUldPKzFXZlJzdE9TaFFKQ0pnUW8rNjRsaGFXVlM1?=
 =?utf-8?B?a0tYRWxGMjhXblZ6bGZNUit2NXpFQ2NQWUJ6RERmdHZGY3g0eEJqeThJNUFN?=
 =?utf-8?B?QjllOWR0a1lBajZxc0o4Yi9hak5qeTlBa3BvMzB5VWkxYTQwQm9LK0tJbXpZ?=
 =?utf-8?B?UFFaZVoyT1lURHNCYUh6c0ZHZFBUSm84MjRYTEg3TktHWWJneEJrUFZKYWk3?=
 =?utf-8?B?bitYdHBUc0ExQ1pPOVNKSVdDclc5MkVPbkx2S3dTSFJxK050aHpqMml6Z3RW?=
 =?utf-8?B?Z01kbEpCdXVESkhkck1TTFlhaHpwS1BEa0tZdnh4MjJmWUYyRkpxUWwwa3RY?=
 =?utf-8?B?cnMrWnV4Z0w0Z3N6dUxIS01xcTliT3RlbldNSnFaSFpVOWNjN3FheUJxSDZL?=
 =?utf-8?Q?z2m/+rJGgXc=3D?=
X-Microsoft-Antispam-Message-Info: zlZgfPumAgaijRWhgXq50vQw8PjfnM5nRac2liGvITg4XMijt2AIbB740zP2lij0VOasgiU3jLGPQ2r7JVZ229QQ/zmb/LuIMRFyRt6/e1gYsLeddUnfIJQBP5weBIuLPT4eI4rP36o8fmlJ8BXe68YsgqyEED9HtF9zRz6vFOIbHv7cDwoSyxTX5K/yPNXiMFoVJ0ghykWgmNuH2r02l87+EOnzUrAgK6P+R2H4xGhlwxiuFyE+wdoYR/KUc+mD1yZsw7FJqExGsg9Aqi4oGVYQLbosStLRUT1zVKCreIFQ1Ji7bwnbf4zgmK6+fxNKAI71CpgtgthC19D55T2H67FqxdZWpDvN6m4dtkg9sUU=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2649;6:ZBPFGauGK904JKEs3BN9pIvSa0+5iQsbQJTbm/MgcBva0aHfJRS66mwahewu/meKh4kCd8G40hjCONVOgoNYwnd1EDJbXda37pLZKiCVTZyXOTW71Vum51G2+wslJW/FuN4nxJLFmEyHu9tvRZoozQmNu0MdTWp2kTHwXtYqGSx0JvhjodN++vADUrv8+a48Q2s0h0OXmB0cosmqnzzocSuigDO83qnNgSHVuhoD5uHK2PcAJXrc1XgnHZRm5ec8Z33R0tqAI2eAeRSs+v7NRzS9SLg8DLLtJcQGf7qRhnz+W+b+ElGZERvG1YX9e9+/UbM8CSRGqfd4AyvbrbdWCJogQUKiKX9arTsMwkesZ6KV50haxNqfqHOmp6aRK+5XxvP8jPQbtSfas3C/Q1d+ImVrKe+3OqDjd+Ih4kKoiv9jraLqVyI+wA4WIX4yIlEcxxYV6mJm8E+5JLT3N3ZEzA==;5:b5bqDicfVas/r4HptKqM1GT9jIg9EdBJOHIV82DbyO/3btRRT//EF4XqMAP4CrbjSLot7w6Kwa7jzPpqrmIBuy52LmYq7kSAQYcTabJUVxDYZPrbazgoLRSdewjDeGiYmwKehNlh3e3NZIb7DZreFvGDGbfheH7de61SJRxG5cc=;24:eskhcrw+ZC1DF/BVyFhBVrPELKTgTEfCMHIxa8Q2ZGHayVLJ64AldhIMOcyb/qdxQQsVlHvgQArIoioy+MG/vFwQ37AQpKvrgiQ3xjZcDII=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2649;7:htTVzDNnxT20IViXy13LbMxQR1yxJWdVzpP2eujh8UafphsGGVd6JeYpFETgKfFGbwKI/c24SZc0nUtC+4MF0eWA6kzKOBoXKwlKRGvgf/2gV/2k6uy3EGEeqqGiafTBY0jr+HY0omgKXLW7GT+1TKqOYbeSxk3v10jGPGOcbD5Ry/F+KJ3b/0EjHBscHQIAKRzpulVkEsHLLyiHqDt2uRRYfj/B/i/RNZi6Gv1menW+RxlOcSJc1oHmp6AXaYk2
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 14:20:02.8529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1a8410-a965-4292-91fc-08d5dc3912f5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2649
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.6.2018 12:09, Greg Kroah-Hartman wrote:
> On Tue, Jun 19, 2018 at 10:09:05AM +0200, Michal Simek wrote:
>> On 6.6.2018 14:41, Michal Simek wrote:
>>> Writing zero and NULLs to already initialized fields is not needed.
>>> Remove this additional writes.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> ---
>>>
>>> Changes in v2:
>>> - new patch - it can be sent separately too
>>>
>>>  drivers/tty/serial/xilinx_uartps.c | 3 ---
>>>  1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
>>> index 8a3e34234e98..5f116f3ecd4a 100644
>>> --- a/drivers/tty/serial/xilinx_uartps.c
>>> +++ b/drivers/tty/serial/xilinx_uartps.c
>>> @@ -1510,15 +1510,12 @@ static int cdns_uart_probe(struct platform_device *pdev)
>>>  
>>>  	/* At this point, we've got an empty uart_port struct, initialize it */
>>>  	spin_lock_init(&port->lock);
>>> -	port->membase	= NULL;
>>> -	port->irq	= 0;
>>>  	port->type	= PORT_UNKNOWN;
>>>  	port->iotype	= UPIO_MEM32;
>>>  	port->flags	= UPF_BOOT_AUTOCONF;
>>>  	port->ops	= &cdns_uart_ops;
>>>  	port->fifosize	= CDNS_UART_FIFO_SIZE;
>>>  	port->line	= id;
>>> -	port->dev	= NULL;
>>>  
>>>  	/*
>>>  	 * Register the port.
>>>
>>
>> Alan, Rob, Greg: Any comment about this RFC?
> 
> I rarely review RFC patchesets as obviously you don't think it is good
> enough to be submitted "for real" :)

There is one missing minor part but I want to review concept first
because I didn't find any driver which is using this style.

> If you think this is all good, great, please resend it without the RFC
> and it will end up in my queue.

I will definitely do it but please look at the concept itself because I
would like to use this with at least 3 other drivers.

Thanks,
Michal




