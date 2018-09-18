Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87126C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FF72146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Plgiab2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FF72146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbeIRR1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:27:04 -0400
Received: from mail-eopbgr700060.outbound.protection.outlook.com ([40.107.70.60]:64584
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727229AbeIRR1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYIlUIDZx3+ykQjrTE6FqbzUmnbZR5Z2HCQKQTV1Jac=;
 b=Plgiab2cvipFajLxS+D/NNn6WuZRyvz03YxYBToNK+/1igjyqHJ2kQUfOX+1LusXVS7jFbYuCzakRggBSBGKBuylGgkry1OfKakqBpqxlMAjHDk9gDKoOnr/bKvH9MLvsiDUPqyHCJBgkC1bBPTmTCHqeIjrBk/H7OrxSmp4jOQ=
Received: from MWHPR0201CA0007.namprd02.prod.outlook.com
 (2603:10b6:301:74::20) by DM6PR02MB4762.namprd02.prod.outlook.com
 (2603:10b6:5:18::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Tue, 18 Sep
 2018 11:54:45 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by MWHPR0201CA0007.outlook.office365.com
 (2603:10b6:301:74::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.14 via Frontend
 Transport; Tue, 18 Sep 2018 11:54:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Tue, 18 Sep 2018 11:54:44 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:42703 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g2Eaa-0001SG-8r; Tue, 18 Sep 2018 04:54:44 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g2EaV-00034y-48; Tue, 18 Sep 2018 04:54:39 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8IBsYCU005138;
        Tue, 18 Sep 2018 04:54:35 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g2EaQ-00034M-Gy; Tue, 18 Sep 2018 04:54:34 -0700
Subject: Re: [PATCH v3 00/10] serial: uartps: Add run time support for more
 IPs than hardcoded 2
To:     Michal Simek <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <gnomes@lxorguk.ukuu.org.uk>,
        Alexander Graf <agraf@suse.de>, <shubhraj@xilinx.com>,
        <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1535980253.git.michal.simek@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <ac23383e-3d54-1cd2-c1f4-219c8ee306d2@xilinx.com>
Date:   Tue, 18 Sep 2018 13:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(376002)(39860400002)(136003)(396003)(346002)(2980300002)(438002)(54534003)(189003)(199004)(54906003)(446003)(966005)(65806001)(63266004)(2906002)(65956001)(106002)(110136005)(8676002)(476003)(36756003)(2616005)(305945005)(229853002)(9786002)(11346002)(26005)(4326008)(6246003)(486006)(186003)(6306002)(230700001)(77096007)(426003)(53546011)(47776003)(14444005)(356003)(58126008)(81166006)(6666003)(8936002)(31696002)(478600001)(64126003)(126002)(336012)(5660300001)(106466001)(44832011)(23676004)(65826007)(76176011)(2201001)(316002)(50466002)(31686004)(81156014)(36386004)(2486003)(107986001)(5001870100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4762;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT064;1:5DnM1bcAbjh+ZNsxPXHP9vUlhZZiPU7ADlzomdB2V8uUFIJQM29hQwbfEOzSEtwpFJGHpkS6xcJDJUVplq20Oh1t9hH3k+uxOE0Eg8jrx93ILRHKBkeo2sKxnxK0OlrC
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9563b146-7bc8-488d-24c6-08d61d5d86ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4762;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4762;3:UvLFpU7HUetH1EhTQIaORI6PN8An+xrNEIgAtBrCjPgYe5dULgy78+Bc3usOwb7YHPYd3gH85/K98pwDc5hAh3xnamCxAGSIAJpRBVxBxGZvnpnB1VVGIMcwahPPu2D6uzwBEH1VQPk/UNIXj+RQAzhyepzV1/1XP7GR1uw/dRR0Z4M41jYrcQEe0fPSM0Jxv38iDYYbOJJF3RVaVkPnQjHG5TCrNZeFrOm8EUPLpXw/Gxkl+HKxGex4uMz0KDz9Sm1kGiSiUgr8GbAaMLo+Y5wqwaBQSP54vgLJebEhQxNsUsXmZ+0wrGzCO5EBSYoPprMhx6iHuT0d3BzIwKGbP7vyiz8YYJgIEpIaiUpC8sE=;25:vpAS8TcEFX8PGip9Wrl+elBkLiFFw2tIPNJbntJAm9lYUA0qq4/CMow7TVYaaMcyFaoPjvp4utfONbHZsz4xf5a5ad9useL1ogb2K/2bgnykayp1KwNJoqjPMieIEsqrxw6VoDMtta5ORSgAXBapKtCb3+3jLI/NJkuflreRe8kaHWORisgq5doIAdQ0JvXtJ/jWwThj2HLyB1zeKZRqkAZlyVsHdiwgvG5Gi+MotsEAgiHweNp8KXLUQTiroawYJ6OmNxjqNJkBStBuIQ7VnZ2/XWGWkfLdxSf2LfbDm1xyg8azATlGWZg3X3sX905sPMMPTPu30sjrC6Sxc20Pqg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4762:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4762;31:qQ+7YoqTtkFKVma8lKAymKYXPxzRxetdXG4A5WqVduHcGKBwFIv6Lu/6nLlZcJa3zbA2sL//KmAu/vyC7ywtcaNfjwoNNuOvdxtLraDTsCkh8WjnXkbFe46fONEWsVBJmV5cE6GFVoZf6t4cUH6RVW9iDueUL/DgCTWI9rGreDmZdkLUHYfWyUYJOyIVU3MfQ51SJriKjtY+UyuowOP/ZVd0V1gYOwjNz6/6uWIJxW4=;20:kd0x/CiHAMIWxIDsfontj38Y0FyhVZMWRH45f7jLbUE7/diZDYVv/m5XIgGbNVNKDGpV7LvRPCI5TOEm4uaZkUKtFWhYDX0fzaADyeApWjVjAh3FJMQRfS2OebMXU0Cu1LuBCKYrlG6HYxdZyrZfmTYWxO5STyDjBtnhhu3CoXmOp/W/5Yf5pNlOGO98iniwhVEhCfuhjQflWppssm+QCOjIxlS2/OiOV/jFR0fqO3aM8hnvJSBbLJfwYUnSU6QFKWxiXrM/T/UXgu0RvSaatgQuRRFR8MB05n4DiBsXCAmQgrp5faCGKe5bCpP0tU057tDwb3vE67/tKyWrchs1t+AaT7eePlHz8gZyIAFZ1rdvFDcuTDgTRSEpbfIY256xkAkpFKHkjF8IU4aQecFGPRbgkp44hCr8mbvzGzCtjlKot9Hc5MuuRMnaTafY9RTzcr+yM9Hp1QRtI23X5qSDRoCLnQDQGkNYXrJmBEuzOmVC5YFQMetiS/XCWFX1K7q/
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4762F7B1D9EC0FCB7B1FA464C61D0@DM6PR02MB4762.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699050);SRVR:DM6PR02MB4762;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4762;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4762;4:9uaUBF124nEQ00qpjVO2Df9vDoLcn0JdBK9+8v1VQxm9AjEhtiN07QZpQfeTnd/+oxzLIl6wW8WYovijliF7dXkJLzE4bwD2z07hM1MQEIu3+/nrU2WQm2JoVWfl0sP1Mbl4jt9dfYxgZVrObTTzf0olOCzTvzH8VFANO78rlh6ToUudl0QOmsvYxGsnXvFHrd0t24Tjj0SOAYvpxRq4cRbYUWeG+NZ6779EN4QG462CoduTPpB+jjx593bl6xAVBO6FcOWtivu2OFhAmPb0OQ==
X-Forefront-PRVS: 0799B1B2D7
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI0NzYyOzIzOjl3SXhtUDV4bmQwRGJzQVlPeklEcm9FMlFZ?=
 =?utf-8?B?YTIyTk9WbnJ6azdpNklxZEo4ZFU2RXJGNVFXNEpwMjZ0TlE4dXVUaE0rbUpu?=
 =?utf-8?B?WkczK25ZZWlWeGl2MU9WbVV5L094ZUJRRjdMSUNjb2lXMm9xbjFybnR0SnU0?=
 =?utf-8?B?Vkk4eUZNYlgyaThkY1JBYkVOY251MCtwdzJCMGJ6dHNBamJJaDBXR3FrS0VN?=
 =?utf-8?B?bGhKR0c0Nnh6Zm1uMFNlSmZuZ1VaLzVUQ21UclB5ZS9Ma0Q1TzNXN21pRXB4?=
 =?utf-8?B?b29kR0lScDRIek5kVmNlaUszZlAyQlM5K2NtUzhGcUVvSGlBeWhnTEF5UHNC?=
 =?utf-8?B?Wld5OEkxQXNYalZrWFF2VEdXRHBFbzJROHRFM0wvVEJzVVlYdFhtak03SXVU?=
 =?utf-8?B?Rk1GemFZSUNVVExxamtaVUJEY09kb2F4UHgxRWZGanQxQTA5REFFdjFHWHFC?=
 =?utf-8?B?RlpQVlZaK0kyNlI0Z2hxajVoTmcvUHN4UGQ5SWtIYWtDV3NLeE1RTXBRbU1W?=
 =?utf-8?B?Z2FrSDIveVVUcjdDZXZzNlhjK2cvc0pLS2J0V1YrUktmdlpPRkw0cUVFZVpK?=
 =?utf-8?B?dWc5R1NEWE1rdG1EYlVqeWR3SzRUdDRYTlM5Y0ttc05IenpIakR4dTdEckdy?=
 =?utf-8?B?Q2xSb2VnbVFiK0E5NmhkY3l1cDR1b2VRb01ncHh1Q0tEYml4aFFkSmc4RXlJ?=
 =?utf-8?B?VVJkQnE3ZlJqUUJia21EVzdnQk1kR0Q5NUQ0V2RSVm9CUmpEQURWR1lWOVUr?=
 =?utf-8?B?b3N6eUlLTXRDTnNKeHhCSTgra3VwYktmZDR0ZnJzRGtVaXA5ZGl6VjVUT3Qx?=
 =?utf-8?B?MkUzdEFEaEhocWMrcFMzYjBQcmpEQ0hvdzNCcWN2cWNlQnZJTnl2UnJmbjRy?=
 =?utf-8?B?M3kzMEJPWUtScXBNWWYwM1dIdkQzd1RaVWo5czVOUlNIVjVPV2hYS0xLSUdV?=
 =?utf-8?B?djNWNzV5cUtjYTVwWGRhQ29qYnlVZHU3d3hWbGNiQUF6cGdwZ3YvWlo5N3BZ?=
 =?utf-8?B?M2VwMTdGbTQzOUlKaFBadUE5NENwdmdLWTRQMlVVY1VYOERST3A0M0NGKzRB?=
 =?utf-8?B?Y1lpZHI3NDZiUmsxcE9mT2QyMFFVRm04WU0zTjVad29rTW4rdWNNM2RYOUNt?=
 =?utf-8?B?cVBtc3RoR3NoK2hTZTJoaFlISERnWVNuTytIVkw4TnZqWldQSkgxWThZZDA0?=
 =?utf-8?B?eStJUEdHM0gvZnJubjdacFVTRmtsdmhUcXM4Z0hIaGdTaTNvQ2g3T0x3aURs?=
 =?utf-8?B?L1lHZjR4WGNOaXFvYmJMcEMzVGF4b09YMDZjUm84OC9kQ1p6M1h5TVoxWWZC?=
 =?utf-8?B?eXZKWjFUenhIelB3aCtUUE9WYU9MSDYrZmZRYWhHY2RhdFJadEFRWFQ0L0xC?=
 =?utf-8?B?M2RqMDFha3BtY3ZFbXBpdCs2aDRiQU50M2FyUzcybUFuU0lIbld0SUpMU2ZK?=
 =?utf-8?B?a0hMSk05M0lmRE43ZFNFUkFoS29RNURVWHpaemNSRU1HUmJPWGFmajM2SVps?=
 =?utf-8?B?SWY5UUwrYmdhcVEyTU1EYUtvemZSTVlVaXhNOWhVY0VMZUhGZ0NJbXE0YnNv?=
 =?utf-8?B?U08wdGJ6OUxsTmlNUmlhWm1BS0ZXTW1JM21SZTZ6ZU5XR3htZHE2MDVlSFhY?=
 =?utf-8?B?WlFZd1NMcUhoRTQ0a05HdlJURzAva2IrTXVUbmorNVVlL0phRHFJWE56ME8v?=
 =?utf-8?B?Q2VzK3M2eWgwK2JIVUVSZDdoUXRHaDNoc0dxdnJCNEMvdHdKcE5yUlhGSDNL?=
 =?utf-8?B?Zko3UXROQTBZVld1U3o5QTBOYmtzNzZuRjFzWldwa0VNUGM5VU94ekwvOVZ0?=
 =?utf-8?B?OEFzcnM0Z2RoSkVpd2NVQm5iNVJhN3NpV2thOHBaNmpRY0kybElhRUdnS1Iz?=
 =?utf-8?B?V24vMnpSalEwV3J4c1o4dnphSFYrTWdtc2ExRXVIQjhWTWU0R0VRNlFHRE9T?=
 =?utf-8?B?KzNqTmRiUDlhbnVZUjlKMHJvT2pkTzFHcUsxbUVOTTFoL0xqWnA0ZTU5UmtP?=
 =?utf-8?B?Zjg4eldoWkxrNU9qWmRNWDRoNlBxMHczQms0bXdhaEVVVkt2Ykc5NUtMbFJY?=
 =?utf-8?Q?3KGI=3D?=
X-Microsoft-Antispam-Message-Info: Ijj99/vugAwwGJ4jPbiCG17KvYw1m7vY3zPbI5y/P7D/ge66xSbUpkE2J27WntDNo+IcOXAKG95+X8fd2x9QY6fA/AzOv/Zx1aH7i0Y2M8uEiSlEggBXnUf/0OK1XuZucytazSsSSzVEO0qQQIk7205Fa5W3dVjRihZgix1juQHluHqzD9JPMB2HiQocEu/pZbCsKDeYYDXkAj0ofLbzcTEe2panuW2/CgeJimCTc0zCHLZiRYzWDV4UKEG50OVj4JvBT7xjQg3xJE2u/deFhK0uTJf4sS9QxS23KTUGluQPgj8rIQGVk2AmoOC1yUL25BWKOyrUPYq4zekf1Sm2zbejexsKSnkPv8hwJiJKNfU=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4762;6:Zrcei1jG8j1Ky1v0LWKTlHDW7/bzKi7is8bu+OFiOTmIqs051yR8qZ6by6kN5TKoyvwMDKmmm5/FXn3Xx7ROiwMhxivf8i1DALUHrAOQyY90ztURLLJ5JWYY1VrrDCnRXEpBEJbtV9TX26Zcm9m4E4xgTyCfk4zE9V02ue40GRJIaNnhTPb4+oGPmznZs62fx5apkPB9nXzIgl3HYgD9UNtlBlKqMewRs+9J9hIixO8EJd86aau/ae7OjFnR/BXdlSIHUCYw+5A2LyKMYpreVY1rH28xtXPQ/XAwn/8Npjl714O2hbL62BumSLzktv1DvgaoKwvVmoTYGaTfNXp5bEfkeQ3oocmSrvZbzvS1l4iPElG5rgJNvI7c7yAjQN78U/6vRDw7Mi/AQRusGk5w8GN/bfXOrbA9gPBATUixUvh7WwwT8vPUtSX2a1bPWjcMnpeLRn+QyWomRpkAVHDQxw==;5:/cbbnePbmqr/l0uY8aPXs+kwbRLoR0h5GldGcONPffjvchza28d63+q8cuko06xRajCBaCnXUOKURc5+de14HvWfl2y55Iqa4YllTYYHYkhMy5JVvYcG9h1/5o1BVuzml9fCZTZX/Aj9Tdx3+NdPZ1fStp76CzVhDECesM3Q9yU=;7:LFBIppkYKrFo1Sseamfm7l9hRPMPYiCgHAnz6/4EzrMVCQFmpCtCrhNeoYlXV3/3/I8Q+eiAD2Em/BmuRbVaVwEFhk00JoccYIgl9sXhpbdnjLdGdver7ofpO8oLICCNg/uj/u0/VisohVsQWii4HXp7HUUgqQnJR1J+377QKdO5jnWugZP4UWb36nA1pQStiVEyNSWvpOjDNN8XoMYqEqIo6YsEouM5jH1LcOfUN3CG2Ei5oFU2JT3AJzHAlQep
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 11:54:44.6468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9563b146-7bc8-488d-24c6-08d61d5d86ca
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4762
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 3.9.2018 15:10, Michal Simek wrote:
> Hi,
> 
> this series is trying to address discussion I had with Alan in past
> https://patchwork.kernel.org/patch/9738445/ and also with Rob in v1
> https://lkml.org/lkml/2018/4/26/551.
> 
> These patches are doing preparation to enable dynamic ID port allocation
> which is capable to create devices with higher IDs.
> 
> For example this is how it works.
> uart0 on higher alias
> serial0 = &uart1;
> serial30 = &uart0;
> 
> ~# ls -la /dev/ttyPS*
> crw-------    1 root     root      252,   0 Jun  6 12:19 /dev/ttyPS0
> crw--w----    1 root     root      253, 100 Jan  1  1970 /dev/ttyPS30
> 
> Thanks,
> Michal
> 
> Changes in v3:
> - New patch found by testing
> - New patch - can be sent separately but there is dependency that's why
>   sent in this series
> - Fix uart_unregister_driver() in error path or when driver is removed.
> - Change commit message
> - s/,/;/ in filling structure
> - get cdns_uart_uart_driver out of PS_UART_CONSOLE ifdefs
> - New patch in series
> - Rebase on the top of previous broken patch
> - Change patch subject ("was serial: uartps: Remove CDNS_UART_NR_PORTS
>   macro")
> - Keep CDNS_UART_NR_PORTS in this patch and remove it in next one and
>   align commit message to reflect this
> - Allocate struct console dynamically too to be unique for every
>   instance
> - Cleanup error path
> - New patch in series
> 
> Changes in v2:
> - new patch - it can be sent separately too
> - new patch - it can be sent separately too
> - new patch - it can be sent separately too
> - Remove nr field logic
> - new patch - it can be sent separately too
> - Register one uart_driver with unique minor at probe time
> 
> Michal Simek (9):
>   serial: uartps: console_setup() can't be placed to init section
>   serial: uartps: Do not initialize field to zero again
>   serial: uartps: Do not use static struct uart_driver out of probe()
>   serial: uartps: Move alias reading higher in probe()
>   serial: uartps: Move register to probe based on run time detection
>   serial: uartps: Fill struct uart_driver in probe()
>   serial: uartps: Change logic how console_port is setup
>   serial: uartps: Register own uart console and driver structures
>   serial: uartps: Move Port ID to device data structure
> 
> Nava kishore Manne (1):
>   serial: uartps: Fix suspend functionality
> 
>  drivers/tty/serial/xilinx_uartps.c | 203 +++++++++++++++++++------------------
>  1 file changed, 107 insertions(+), 96 deletions(-)
> 

Can you please look at this series?
I have sent 2 more patches on the top of this series where OF patch was
reviewed by Rob already.

Thanks,
Michal
