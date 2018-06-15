Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3AAB2C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6D920864
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="RQAyhqX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6D920864
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755587AbeFOGvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:51:04 -0400
Received: from mail-ve1eur01on0080.outbound.protection.outlook.com ([104.47.1.80]:18624
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754119AbeFOGvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+FlDxRKA3+mg9x+GaRmIOZXq6yyQqcEcHDcIXAfWtU=;
 b=RQAyhqX6LhyI775ir5REHeUnJRLoh0rD5miDPAWCpsr3QuyBSMa/F8tClU9wOqQM17EPD505tSzylI5NSFhj1cuQAAmZzpLVMnZE8bLLTGVx91ctPS83phHM62da5vPDHEk+dxL2pmfBoSPlMEHsW0fmd6WZQy4RoF1GWlVXC78=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 DB3PR0302MB3211.eurprd03.prod.outlook.com (2603:10a6:8:9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Fri, 15 Jun 2018 06:50:57 +0000
Subject: Re: [PATCH v4 5/9] xen/gntdev: Allow mappings for DMA buffers
To:     Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180615062753.9229-1-andr2000@gmail.com>
 <20180615062753.9229-6-andr2000@gmail.com>
 <e892748a-c268-9622-e568-4c361366bce1@epam.com>
 <b9c3f740-dea1-638b-49d9-60cf5880619d@suse.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <38f10738-63b6-89ce-07a8-7791b2a7e4dc@epam.com>
Date:   Fri, 15 Jun 2018 09:50:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b9c3f740-dea1-638b-49d9-60cf5880619d@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM5P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::39) To DB3PR0302MB3211.eurprd03.prod.outlook.com
 (2603:10a6:8:9::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67d0cece-0b7c-4ca9-ac0d-08d5d28c59af
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0302MB3211;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;3:dIaZupt6ocRUGq6OnIozErGYHcxYXehjzNrz3HF65qbZV31led1+d9SKZ1ALcZdoKqh6tttqmnvzLvvOe/EADprHDuJbn8kmhtMzx/ARdyrhp6GsVYQiVVpd+tB1G0YB0levKHUp+3EO1jTXsqLVHUrY8RGLwlMiySxVt52Gr26vpb/FUiiNpHfbk+P0eLS5T6IpibUKkFqX7BF00rqroZAvToDb/Q5a9ENzbbheg+uzIQNAw3eyFWs91CRrZeUA;25:tfVzRzvPCYYvPsmXdKKfPcjFSEa82/AVv3TlnF1NFrHwOPhRjdlUcghM+8zR+yqrgKwHZrj/qdGcY37/ci5p6vd4gqd0Y4QzZ0jsE8/yt/4wo4f8b0jInJ4FEZWpx2+VPLa+NUu/CKUtRqvS7N0Ja4VFG0mq1IAMrZTotjlGlznZLzLvKup9vzhwNkY3Ebgg3zTYYzZ61whiIqxyUjv0jGVP5BGc6JeIOAidkgaIZgQYUlh6gyNwn4og0WTjCqrc9cdJ+C2E7bGCVV/bq20CqYuqUyGG+PMzmI0DD9llNk9lCJ+6dL5vCcQwWDgYLx0j1m2LS2g0BNPZHmqmOnizSg==;31:F1obFp5oYdKepWuLqQPtC0vn1j6yE8n0s8rkcYfI0h6avPrmOCxsWIVFNnciBV265lVSEnDrCLfJMlrn3J63MLzzPz7SRIgEVb4h0xHrEA9r+GuKdkIkogqVpWVzdtR5hbMg4B3HGLD/FFlhrRjzcBSpJDGIw07DcvtNWX6FabPzZzce2MIYL+frCxI1et9m51WCxrQ++O+B//nV/mm0plg+p74OQd64Sptwy6QM0+M=
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3211:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;20:RS4UWKENn6EK+mkcD3ZOu1WfDn6vyF5RVh35o9h8xbNGVINWMT2nX41L8a6uztFzrcCCVBEk8jHtHDquqo1FmeM1RC/GECcWzSRP1YL3zzbJV3AT06OQZiGzAKVLtPxTWGJLK55yk3t8yNDYzB4Y1nLA06R9fy/hnWY9P7uQsiXPfHvDArbTGbbpEVqO3mre8448htbnNA/i4wyRMxMoRovhBIBbB5R8Awo7QlwzNx8LtkxPWTxvxRZ1iL5BWSJtvpZwNIZaa9a1PNmXi0QfdXo9+tQyOeuD5jGVYcV1SaQZIsAXGFLHmEWU2d340pR8+lxzBfA42oUQwAru8Q9TkhAVL6ss3hqvjk6wF8nWdS3M8Xn9XCA2hSjPorfODH7qpQdKVvpmqcAXbbvRR4qqosOWU9oy2XUA8bfACth4duZu0DYBVWtWfNg71BlNHLKONmneUBCpPnKbQdcYvD4pcV+1DYQ0PAmFYceIE7KaIvrpSX6XsWir0jZRGSTbAERK;4:fflwFBXQuUZPxvpZZr+dV6b4zBibgWYNlPgbcw4Fs3nQCnrWnkuA13fxF0E0CuF6eWePjGxXTpk7rfT0xM+2mIIbcgbuiodCssN+3/CScvK/KNqdf5qv4qWV28r/dSyF82J6UmPC5M/8k2LVS2sHdM+YWY/33LaR6OQVB0FSXAUxo45Ke32abjY9lvmAjVTi9VFQPID8y/2QzdCccD7TssboFX3haN1JnU2P8bZnDsLP3UEutex6IzRKPM6LB38hsAUp8lC+I3G/SQkqhR8Y0w==
X-Microsoft-Antispam-PRVS: <DB3PR0302MB32116CB0C701EC0859769A1EE77C0@DB3PR0302MB3211.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB3PR0302MB3211;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0302MB3211;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(346002)(376002)(39860400002)(39380400002)(189003)(199004)(2616005)(5890100001)(97736004)(229853002)(65956001)(76176011)(31696002)(65806001)(106356001)(105586002)(66066001)(36756003)(26005)(53546011)(386003)(53936002)(478600001)(31686004)(72206003)(77096007)(6666003)(4326008)(6246003)(956004)(86362001)(55236004)(25786009)(80792005)(47776003)(39060400002)(23676004)(93886005)(2906002)(316002)(16576012)(7736002)(305945005)(58126008)(7416002)(50466002)(6116002)(3846002)(230700001)(11346002)(68736007)(486006)(5660300001)(52116002)(81156014)(16526019)(81166006)(476003)(186003)(67846002)(8936002)(6486002)(446003)(52146003)(2486003)(8676002)(65826007)(64126003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0302MB3211;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjNQUjAzMDJNQjMyMTE7MjM6V0c4bmxFem5VK3FqOEFsKzJmWUp3Yi82?=
 =?utf-8?B?amZRdE9QdzFRMkVSN2lacHJyNGF6aFhiM3hndnR4WWtEenIyT1NwZUs3TXln?=
 =?utf-8?B?OTdPdklwV1hDRTQ5OGxwdVQvaisxS2ovemtLeG10ak90b2gvR2E5WXh0dUho?=
 =?utf-8?B?RzJGMjJiMUVjMkxubWZCOVdObFhVNmRzYmorVGRlZytXYTZqRU5GbDNxRWNI?=
 =?utf-8?B?RGRtQkVjb09rRk1xVU1DYncrSkVCK1Bxc0xxOHBlSWppaUJncFZVWm43Mm1I?=
 =?utf-8?B?RFEwMzV1Z1hETVdxbkZLLzRnWjhYMWZHb3RRTGYyQmlGc2VGdnViRHBtZktL?=
 =?utf-8?B?ZGdROVFsY1VaZFptaUF0TDRPU3M4T3FSSWtFS25xK0VaNHpTeVNkZG5Xekhm?=
 =?utf-8?B?NGxGN21UdkVYLzRRYSswTWpNdUtwVys1UTRkVEtwemo4UFBmSit0TnNiQXZa?=
 =?utf-8?B?T1FwSHgrUS9lT1o5K1dCSVFsQjhzRkJVeEtNYjNqUDEyajF0M3dtd2VoQjNr?=
 =?utf-8?B?WnVkaWs1Rnc2Lzh4b3dDR014RGxYYjJtaVlEZmV1SENqTnNDdUE3Z2lPSEdE?=
 =?utf-8?B?QmJjZnNyYkYvRlJVeUowWU9nTWVjUkFtV00wVzhlbEg0bkJZcWtHa0Y4Mk13?=
 =?utf-8?B?a1h3ZWV4NksyZGN4WVVzZEZuVjhUZitXUHR1L0c0dFRNNzhMSkczU2RFbUFl?=
 =?utf-8?B?VjZScXcwSFYxZGpMMHgxWTUzdUo2ejg3US81aFJVNjRQSkcrN3I5ZkNScUI1?=
 =?utf-8?B?R3JZVWJpdkl3cEh0WEU3ZzJTTXFRZTVHbXNRQ0JuL2RqdXpZaytrV2dDU0g1?=
 =?utf-8?B?OWs3ZWJLSmlNS3J2NVUxSWR0Z0trNnlnWStQZ0I5TmN1blVYMUxvRENmY0h0?=
 =?utf-8?B?RGlncjhNQ2U2L2lPRS9jRzVoVW50eHNjcHhiOEpjWW5BMm5xeVBZa3U2WTY3?=
 =?utf-8?B?RE4wN3NDb0cycUxNRjdZZmoyUXpwYTZaMUNIWjFoUEdlOVlRL2dVVm4vdzlh?=
 =?utf-8?B?eTFsTnZEaFFZazF6Y0RLVGFlWDYxdU4rK0NNMVFHemxpaVpraFFXWWlmZmRB?=
 =?utf-8?B?bXAxSDBPT0FzQ3FGbzhZenN6ckRqSHlVeFdoYXBYWmhzZ0Yyb3JRbXJQQlcw?=
 =?utf-8?B?R2gybGJTVWhIaFFudnVaZllmZ21QWmxUZmRSYTlrRm5BLzJ5RTA0N2NTczls?=
 =?utf-8?B?UEdISEYxUDU0b0ljckZpaDFSTmhwQzhaWEVNd3AxMUNVOFg4aE1WcklOR3JQ?=
 =?utf-8?B?RFdPNlJSSDdOZzZxcEViSUVxaHhmTy9WUzFOYjVKeFY4Z2tIZEc2czdNQTJS?=
 =?utf-8?B?VjlpbEM3Z25JcVo2TDdIZUJaL3dPcGxKcDJBaHR6MVlBeHdvMzV5U0UwRDZV?=
 =?utf-8?B?UzBIb1FpUkhPQWJBMVhwSWRnTHdxVTlhMmVJSkxqM1dTcmpmc2FaTmtELzFx?=
 =?utf-8?B?YUpsZDMzQ0FMTjQ4UkREYllEdU1SQ1BCeHFPMDlFaEZjYjJub0JwSi9HeThV?=
 =?utf-8?B?RUE3anFhbTdBMGtRcDRGT0ZWcUxtdHluS1kwa3NDK04yaVQrcVgxazY4N3FZ?=
 =?utf-8?B?UURRcGFBa3J0cE1WUzhWUVlXNmJncVl0c09mVkE1cnVLcyt6b1dQZExHYU1Z?=
 =?utf-8?B?ZE5vSlNLRE4vR1RuSFhZRzVsMHE3bDR0Y0QrQUhaOSt5L2gzejU1ZkxDLzNl?=
 =?utf-8?B?dEhjbFdGUXdoR29MemxKa3dlM1VLWGt0VFNPMGdSMG9TVEVYRFZ2UzFtZnYv?=
 =?utf-8?B?Z0R0Rkl2RThvZHFnNXNrcU8wTHRseFpsMHowTFFNTzhCN09FMzVNYll6QWFN?=
 =?utf-8?B?L1hTQzB2VFp3bmFBUnFFR1kxU280Ukl5YUY3eFpyQktlWGVoRjBFWk12azQx?=
 =?utf-8?B?ZkJhRkQxL1o3bG1MdlJjazhwNUgwZnlJVWpDenRpRWZQWmQ2bk9ZT2JPaE5M?=
 =?utf-8?B?cHlUMVZKWThsdjQwbWJ0eW1GNjVPa0dEMzBGT1VjZW4zUHMreVFSVTB0Qytz?=
 =?utf-8?B?NG9PVkRiNFpzdysyb1VGU3JaYWNOOEZiRlZ6eGVUdGJHSEhicHgvbFFEMlBM?=
 =?utf-8?B?SGZLL1dmMWJHVlY1YnIzNmZpVkhENG5MeW5rcG54cU5tSGJrTzY2RDFxb0xF?=
 =?utf-8?Q?dib0Lj5NORbDiNUs7b9+rjJF4U/mRvTaEA0PPfckuwV4yG?=
X-Microsoft-Antispam-Message-Info: xvTT2ZeOOnXwQadBYBv5ouGbYNAjWjAjNIjY7PfuOrLVF7jp/hQHc8T4jy72LrMnk2owRfUuk5gQgnXiLtqPAhooanQiaQqpBi10RBquuWM62mOT9Pi4vqMKPnZmzeK30G//lVydEZdx80TcyvnpSScaF7O4leSAWBe/EQiGnvEOP2MpfVAufjQiYkJc2OFt
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;6:Dd9PU+dqfubkHCKBmVHS0yMXgmyP3lsC5QnSIBd4bWzQICODvEU5xGtVHmAiGinNNMwAYDwHdhsclRa0MXwAf/V7BEbzaGz8PB+oou9sjafF93weiqIKobWol1tUn8VXnNPYnrAN98cMyD7XTX+lL6KIOMoAG2ZzP8aSaTEWmOWBQ2TxvoFYZTWxmmQ17n7boXL7JbwMZ3nHe/+UVuW3LEdKCeexYOW7vp5uAOH8653+yyOl/2BAdnV58wJ/OuR7fRRz2trzt3K4kJgpbUPuWMrUlLWSelzbtzIkm1Y8oIf0kBrzNGwHb/fWfEFz8OnCe9EM5VVbNwo+RK1ym8ccqLDD6yFYLKU9k88snhQjKDRIxx9rqB6NcpPmMU3CBDW2es3xFVOBi+CBkJBUQMFi4RzpN7bCKitKg6eaP4FbWX1wc/kzFhK1oIIp642bQSXzaIt0ByUFiBff/2Iy/77FvA==;5:knQp88S0mAgsj9D1o16JbwRbofa8lMr/82/n7o8IouRNS6qt2TLaTQ/Q65x2OY+ODDo2rTuXJsO/kwM2rS1sNn1eissqy+aGEXNWwVwKq60fMhUj3qndS5L+rcSec252tsdtG6R04vbqrW4HFrIOppYoDwp8DWQLMqO3dHfl5hE=;24:GLh0O31VRPDv1hjzjfHPK6NqBDHQNw7ujMxw8yGNs8LHIOtE2a1xT+azLeZhkZkbSDHYwAxXZ58m/Yi1mdsxM6SyHhqLZ5srDcpiAWR6iG4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;7:N+rTLoNIleL6QeOQMQUZ9nCouJG3C4Nz2aGhPkoxATc8YphgVCaxSEmGSYiJ76RK8ChrB1GaAudZIHahz9DLfKWxnizJFyH6UYoVcPuyfivsLcDDmpZs+HvfNYscQ0drwZD23MKu+zjhtTqj1rhTVSOsoKiDnX1Y2lC20kg4/FclYNxJs5jK78ey8jsV5iH4LqTIO6+0D4Y4QRoGCF+/VgA/Ns5PopgHct/ckOsfHnKa3yFZWqe5jquNwDVbcz+7
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 06:50:57.6046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d0cece-0b7c-4ca9-ac0d-08d5d28c59af
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/15/2018 09:46 AM, Juergen Gross wrote:
> On 15/06/18 08:32, Oleksandr Andrushchenko wrote:
>> Please note, that this will need a change (attached) while
>> applying to the mainline kernel because of API changes [1].
>>
>> Unfortunately, current Xen tip kernel tree is v4.17-rc5 based,
>> so I cannot make the change in this patch now.
> I don't see any chance this series could go into 4.18, as the merge
> window is just closing. So please post the patch based on current
> Linux master of torvalds/linux.git
Ok, I'll wait for any comments/r-b's and then rebase to
torvalds/linux.git and push v5?
BTW, is there any plan to rebase Xen tip kernel?
>
> Juergen

