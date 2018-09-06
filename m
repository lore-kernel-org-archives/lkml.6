Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A173C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9C52077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9C52077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeIFNaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:30:14 -0400
Received: from mail-bn3nam01on0058.outbound.protection.outlook.com ([104.47.33.58]:23369
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727865AbeIFNaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLaEbkodoT5l0AKF5txbf0LbRtz2RY6H8ygxfC5pei0=;
 b=lFTH56fgUhWfGqsrvHCw0ju5UNyktvjyKJsCYiFIQ21TlUGCtjs56a8YMUo7vxVoNUQXCsaOBm+6tdkJVLpuXmzzp18oHl3nsjlWlIzUdNwQV0DDB/CcA6LsR+tpWPd6+ZyLQZsipoqyPMlNYmjwiCC7zhncMqFCKq2uo+dIr0s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tomasz.Nowicki@cavium.com; 
Received: from [10.0.0.85] (31.172.191.173) by
 SN6PR07MB5184.namprd07.prod.outlook.com (2603:10b6:805:6c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Thu, 6 Sep 2018 08:55:43 +0000
Subject: Re: [PATCH 1/1] coresight: etm4x: Configure EL2 exception level when
 kernel is running in HYP
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, Jayachandran.Nair@cavium.com,
        linux@armlinux.org.uk
References: <20180904142034.19116-1-tnowicki@caviumnetworks.com>
 <20180905203436.GA16793@xps15>
From:   Tomasz Nowicki <tnowicki@caviumnetworks.com>
Message-ID: <43b83d91-8cec-9926-5856-a4a5655711cb@caviumnetworks.com>
Date:   Thu, 6 Sep 2018 10:55:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905203436.GA16793@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.172.191.173]
X-ClientProxiedBy: VI1PR0202CA0030.eurprd02.prod.outlook.com
 (2603:10a6:803:14::43) To SN6PR07MB5184.namprd07.prod.outlook.com
 (2603:10b6:805:6c::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 339f1bec-3d95-4a60-0b9d-08d613d6886a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5184;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB5184;3:drl21vxe7Z7/f/9ARkRojGhqINPs21N7X8EQVh3y9oNGXmhx+S6BcqbYNMQX5XPGUgMYCWmX0UJatZoNUh6v7i8CVINYPcadpEV1Y1SqjyNKMf5W3PZ5exzU41STHXCLq/lxzsbDwTqea9TAGBf/uurAJxJ7d/tDIRN7EHGOIzq88+0QkaI08kh0h4vhku/sxOkN7dE3sNSzER9XNzGVud6+7hsfhZx1akjwKHSkP8D94JK6XlyPXyon/2rh1qD0;25:Qm/jM2Q3hEbtJQCJNYo6aPo9eKpANR6jez5hJ7LnSV9zQ5cblT6vTBzL+9ZSm81st1ArUqN+uoZ8F4mSSMUrxI5T4UxZRokJtC1DDhlgQFdsozU570uymxWvVYZUMyc/ZkkUcKuEE5JMSLTov4SdE04GAu66yNf2s1JSQ7Ri9ezLDREGK0OhRm0jON7iLYOJwp7+ls0g29mXD0GuVwMfHH7hcS8BJcaUqq+TcODRZ2w76pTVLAEPO7954lvsYv0Bv9nk8N2tSj1b6+gRVUbo5t1tiNNGbJqBmjDkgyYq8D93vbKZSOHvCrmXe7jG1OqOriUkZPhF3jeHVtwPv63Ojw==;31:d5NWSzfGNszm8f/4yCk1YHBF+A+pbhFFNPmnhS43j6W0WHj8tNGs8bHDBgKAvf+wnyhR8ll+BUBqEJSB3zRqFLdFuMUNfKGYUU/Qdp0GOIGAx1GL4eaXrMvRYMCHeZtxG8gsQ31yFzBcc4ZxsaiyiJnsEQYBcnjxcx/m57wugxllUMUdIvBTRIOkxkkb8uJO7ioz468tTYI4hMC4HpTbR5xdPMuYD4mZY30t+wnGZT0=
X-MS-TrafficTypeDiagnostic: SN6PR07MB5184:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB5184;20:oujtKiLF1Os9JLSNz3SMGV9l/H4gSL4fikgVeboPGyLGjjZddW5LPD33vCNj+29r88ROZj3f2FJr3gp+HILNxMdYliIlaaVOi/lommu78/o9nn6WKFT4S3Ihmjys0PHRV+moygo0zFeFHWTQ84dXATgcFJx8ZovV/XyTYF5Ru0a3GXqiiPKsePQgpQ2IKpfBsBhwyyYAlLIwN6K4XjpAgevFKja4KAY15zNI4YXwTGHJ0UflUFzBNP4WltIhu7JfOerxYZllxY0IY1LJE8m1la9zIcA1mmNEgPZJQHdREJpdU7+pE3QP7JtrSSAO+0h/fdb8g0D7l9XbpzxXGqLdmTIGcfPX9qGlFd0rvFqeP69oAeK3XjaYIyoSIl4GzL64iq+GCNVnDYwZ0jMYpD8WLz/ct0G3YQ3w7vhavHbB3YMP8jfgRbcPq72m9jIusBsdH5d1XT6iiE3485WIRG2beVJNDjiuE8bMGWRnn6rXf/RE3i3RiJC6CGximZt2G+KjZqSiWMIonxefPVlcBBfJvNcXRZDnnMaSikFraOXBWcKxaG2ypsImxuNEZmaWNs+Ek2hkcJLFb7xRqVIHJFDcR2N6gBviNqABp0rpyNADkiQ=;4:F/fLNapvhCBN8zW0Hx8EKYAN9xFRKfxkOttgUPBFacAor94dXr7zN3rqn2p0hAIaCWM0f8XAOV7siTfy7xfos8L9HMVzg9tOaCTC4XvyDI0EK8+a55VwNesu5NSM5JZzgwL5byGPbYdL9gzk5/sOE7wQVihUQ15dqeDFtwZhVRezBm9CTdgQDwLVBpH9WpDCk+lY04GXCn4bmbGgvFgTeDsv3hwubT512gFW6x18fuGhNZ6aaMH5LpIZp6da44rilgsqCv+r471N3YrRS03QrA==
X-Microsoft-Antispam-PRVS: <SN6PR07MB5184D66D76EC2D3D4658B33BFE010@SN6PR07MB5184.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:SN6PR07MB5184;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5184;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(396003)(376002)(346002)(136003)(199004)(189003)(25786009)(7736002)(305945005)(4326008)(476003)(67846002)(486006)(2616005)(229853002)(31686004)(53936002)(16576012)(316002)(14444005)(58126008)(105586002)(81156014)(446003)(81166006)(8676002)(11346002)(106356001)(36756003)(956004)(6246003)(50466002)(97736004)(53546011)(5660300001)(478600001)(72206003)(6116002)(64126003)(3846002)(575784001)(47776003)(31696002)(26005)(386003)(68736007)(6916009)(52116002)(23676004)(52146003)(77096007)(2486003)(42882007)(6666003)(2906002)(8936002)(230700001)(76176011)(16526019)(66066001)(65956001)(6486002)(345774005)(186003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5184;H:[10.0.0.85];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjA3TUI1MTg0OzIzOnlqTnM3eVRKM3pjc2EzdGx4TzBwOURNT1lC?=
 =?utf-8?B?T0hyYlBRdngzdENmeXd1V21JL05LSWpweFRwZUxKTElOM1dwVlQvemJ1Uk9z?=
 =?utf-8?B?TlRMK1VIb2tES2hhZXN3UlBOS3J1UWpyeUhYdGhwOGl0OGEzNzgvMFQ3c3NC?=
 =?utf-8?B?bXFMeUFFbURVajdkWHB6a0NFRDZFaHpzR2pnRE5LNlp3NGQzaTNMOVRETk1M?=
 =?utf-8?B?M053QjA0SU9LZlJRTUhMYjA0UWsza0g0M2ljSjJyRnd3cEpJSldnSjlrdWxp?=
 =?utf-8?B?eUJ2TEIvTnk0MitIN1l1QmJ5V0J1aU5FU1RIZC8vR0NjN2lnaCtoWVNYTVNO?=
 =?utf-8?B?OVpLZHlSaXZGK3M0L2JoeWFEVCt0d2dSUy84VzJub1F3ZlNhWUZ5ZHFEZytW?=
 =?utf-8?B?U0VlamRSWmZqQnBMSTMrY3NiWjBOdWJMSWhNK2dWeHpRRkE0YUUwdHB4cUlr?=
 =?utf-8?B?bFRnQnBPMVF6Q05iS1NyN3FFdmZnRjgySjBZSW5EZjZTSXhCYjFYQW5UN3Fj?=
 =?utf-8?B?aUg3aENRWmxZcFlJNkRqclRuZWxxditzZ0t6dkxXWWNtdHdNVEZYWVYzQjFY?=
 =?utf-8?B?V00xT0ZFRC9PeS9jQ1ExcllYODNjRFZleEk2R2dhdW81ZjNsSDNweklrQmZC?=
 =?utf-8?B?VlB4ZHozakcyUm1yMi83L05FMmZRb1Zod2c4SDJ4VC8va1lMbUdUZ054RW1v?=
 =?utf-8?B?Q3hTZGtlSkkyUk1LVFRQQXVUQklBS3lPcitZQ0FrbTBKMzNkdE1kR0p4OGN5?=
 =?utf-8?B?K0JLNVQ5aTVkdG1VTG1BUW1LMHFPWVhFcjB3SEhGQmZ0clJXdzBENlBlK01O?=
 =?utf-8?B?SjBmaFNTVFhRV1ZNQUdzVk1SaGlrSnp0VkRCcTc5ZEk3VjdYVG1VbUVVWmhG?=
 =?utf-8?B?V1dCY1ZxMEFRNy9EWWZmU3NLNjlYVm5oVjVEUGwvV0UzMmpMcSsyQy9XbVpl?=
 =?utf-8?B?bXZZWVJtTi9RNDBBTG02R1dBOWlkb0owQ1o3S0JDQ1crN1pWTG40cjd0eHhI?=
 =?utf-8?B?UEN6VjNKV3FBSGQ5OUlDb1ZxZWNKeWkxZFhoaENCem9WbXowUTBDYmF3SEE4?=
 =?utf-8?B?aVV3YVYwUEpmZlN4TlVHZzNLSnZFQUFlN3RHbVlMbmkrVkJYZHhFN0lrUXpT?=
 =?utf-8?B?U1RKRW04TG1tcUczRE5UMUl2bUwvSlVNZTVlbkdENFBDZk9JYzBXMm5YSGo4?=
 =?utf-8?B?bFBrMVBZR3kyMnR0Y1Rpbk1taXNKVndEMEZGZ1JNcDk2Tkt4Ri95eWswRWVV?=
 =?utf-8?B?b2I5TEdRYzUrY1pjMXJYY2o5dzk3Q2h1UHdCdit5MVpUV0xFdVRTZ2pTL2RG?=
 =?utf-8?B?Y3pCQkV0cjFqMDJoVFkyUU9SZko3NjBRdG5LQytzL3JLbXl0Tjl0OE9udXlU?=
 =?utf-8?B?L0NSTlNKLzBLclBnR3FRb1Q4VEF5RlF3RnR0dDZuV04wcStyVGlBd3NGejFu?=
 =?utf-8?B?RDkxMmsxeFBKVVp1MWZYbWVoaE4ybE9nR2tKVHFOUGROMWxoakZ1SWdMeUU5?=
 =?utf-8?B?ay9xVGNTQU9pbVZHTHRySEN4QlRvT0tTMklHOUtsQVpxcHVRbjFkNmtpRXdF?=
 =?utf-8?B?S09XemFNb2l1WEdBOTJVY09laUZVYnl4c3JHYW5NVXkwNGMxanFWOHlEeDFn?=
 =?utf-8?B?VlR4SXUvZkVXaXhSRmdqTUJPSSsvUlI3dHV5V1BCS1dZYXlaOGxaWkNoYWpI?=
 =?utf-8?B?dEh5U2J2aDhIUGIxaWpjZEJJYUliWTFaTDdlRTNCa1liY1pHTmltOFBlR2RG?=
 =?utf-8?B?L0ZLZlR6czkvbmhWQ200NXFPeUlGUmxEaUFlWmZVZnJCdnVMeFc5YVRiQmlI?=
 =?utf-8?B?Y3MrdkJ5bC9Fb2xFWEFpVTFWejhJOTl6N1FXN1NlNXRJL3NDRTNURDBMUUxu?=
 =?utf-8?B?UzcvS2FkdlkwdGZBS2U0WWREeGdXWFdQYlhMcmlvaXR1L3NURnZVY1ptTlNy?=
 =?utf-8?B?SERSUlI0eWhOWVdhL1pCc3d6UUs1bU9ySGZWMGVNcm1Eb0hvbVl2QmZ4UUZt?=
 =?utf-8?B?em5qZGt6bURnY2NaUm1NUG1yU0h4ZEJOWWJ5UT09?=
X-Microsoft-Antispam-Message-Info: t3hP6U/UpHqz+AgDI0B4/YC9aP/x2UoN5kEr3iPq/Xi4JPAla6O2zrqfKyKjuW2f/LpD4DwT/cv3+FbocMmN6VtgwC5cLI1TRghXISEQ5z9TU8fwpdkQ4pa0+yPI2CUmI8ZeO2SIoqx2Cpx5tKQD8Um7pFdkVK26QvJij6ePBBEnb7ZHH2kdY5aMxyhlds7rR6IQyReowRodHAEtDzg8G9n5C/qrF8IAPN5TvYG+Moz8zWbsmrLrSm+GEnBVRlY0AHgnJy2ISZHSh3RV++CpxFUGr+wnPjcRNB/p/grhqBaxFVpt1At6u5ioVVBqa7K1loZyBPNSPn79yk5WL7hKSNa5MPjSqxE377nGUxNRunM=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB5184;6:I4i6lgDUaIpBB4cOaLoAW3cJ5T7HTfpiKGOfL8JlRarIFC5NTsDiWbIYCRqYHumPq9QKCOH0YRtHjs/QW2gdmaVW6CT2kE7ZZriNJkZlP0dLyr5AiFkVjBM74xbYWh0T1BB/xKcMa74RFh/WJiH24pQKLXNK8D8XGebTpTsoixI+O4nceyj4e2Zxe8aXoi2EZgCwN4AJlf8dXMIRF04pJeD/WB+Hb0h1G1KtGk714yGBkkPMhTuFlRkRKqaz8zucm2U4KVwKPtOu2HVOOJ4RuRmfPLgv31boIOChKQkswsbgSvHsZE3BCpBziwm5TZYi45RLhRkCfuQphrEzZMHGbbcCX0F8gj7mD3av24pn8w5fQSIfnoLn5W4Wy5Ks8BizrvotPn6JQyMjJPk/TZe6LxnubDhHI6/kltrO3Fc5/dfLEGuetr/0TmLmRJRTIWR+fd4BFHK0M0SXMgeclqW8mw==;5:TqdAnmTs/AWbwv31jXmYqqkcL1xzrNC2svelBzmDynOEtqwFjgVunZJOHQ1dvrWlDAbyc18z+O7k8kZGkiYkOA2Ak3ERrNfefM/hrqQkQ0zDjslS+gVnrJRGG8BOW5YD+DFCxz5yg/YLEI6k8E1sy+7ReKRg/UWDwIWitAUqFMQ=;7:bS2Vm8zIhnfY9MTJhLUHrCjZFWm9SnlZ+8RP2Mvt5JdzjHxHYhHTLf1aaQksvKWwyiuVxyLSVTVL55PRh1whEyp1mZdvmELtaN1PF309rRv1fLjhATE/7DQrS+xsQW73N2yt9YvFIEVn6W1kxseiIJlig6r9/bJEtVn2ip0OXZwA8izb/NAj1cMKWFMEdkCKLAQFHh7JJLtA8eIzjmCjOX9et2ltoen0b6+aER1ov1OK2uhLsNKuJmo7npITZe1v
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 08:55:43.8674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 339f1bec-3d95-4a60-0b9d-08d613d6886a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 05.09.2018 22:34, Mathieu Poirier wrote:
> Hi Tomasz,
> 
> On Tue, Sep 04, 2018 at 04:20:34PM +0200, Tomasz Nowicki wrote:
>> For non-VHE systems host kernel runs at EL1 and jumps to EL2 whenever
>> hypervisor code should be executed. In this case ETM4x driver must
>> restrict configuration to EL1 when it setups kernel tracing.
>> However, there is no separate hypervisor privilege level when VHE
>> is enabled, the host kernel runs at EL2.
>>
>> This patch fixes configuration of TRCACATRn register for VHE systems
>> so that ETM_EXLEVEL_NS_HYP bit is used instead of ETM_EXLEVEL_NS_OS
>> to on/off kernel tracing. At the same time, it moves common code
>> to new helper.
>>
>> Signed-off-by: Tomasz Nowicki <tnowicki@caviumnetworks.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x.c | 39 ++++++++++---------
>>   1 file changed, 20 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
>> index f79b0ea85d76..5f495c942f99 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>> @@ -28,6 +28,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <asm/sections.h>
>>   #include <asm/local.h>
>> +#include <asm/virt.h>
>>
>>   #include "coresight-etm4x.h"
>>   #include "coresight-etm-perf.h"
>> @@ -606,7 +607,7 @@ static void etm4_set_default_config(struct etmv4_config *config)
>>        config->vinst_ctrl |= BIT(0);
>>   }
>>
>> -static u64 etm4_get_access_type(struct etmv4_config *config)
>> +static u64 etm4_get_ns_access_type(struct etmv4_config *config)
>>   {
>>        u64 access_type = 0;
>>
>> @@ -617,17 +618,27 @@ static u64 etm4_get_access_type(struct etmv4_config *config)
>>         *   Bit[13] Exception level 1 - OS
>>         *   Bit[14] Exception level 2 - Hypervisor
>>         *   Bit[15] Never implemented
>> -      *
>> -      * Always stay away from hypervisor mode.
>>         */
>> -     access_type = ETM_EXLEVEL_NS_HYP;
>>
> 
> Extra space
> 
>> -     if (config->mode & ETM_MODE_EXCL_KERN)
>> -             access_type |= ETM_EXLEVEL_NS_OS;
>> +     if (!is_kernel_in_hyp_mode()) {
>> +             /* Stay away from hypervisor mode for non-VHE */
>> +             access_type =  ETM_EXLEVEL_NS_HYP;
>> +             if (config->mode & ETM_MODE_EXCL_KERN)
>> +                     access_type |= ETM_EXLEVEL_NS_OS;
>> +     } else if (config->mode & ETM_MODE_EXCL_KERN) {
>> +             access_type = ETM_EXLEVEL_NS_HYP;
>> +     }
>>
>>        if (config->mode & ETM_MODE_EXCL_USER)
>>                access_type |= ETM_EXLEVEL_NS_APP;
>>
>> +     return access_type;
>> +}
>> +
>> +static u64 etm4_get_access_type(struct etmv4_config *config)
>> +{
>> +     u64 access_type = etm4_get_ns_access_type(config);
>> +
>>        /*
>>         * EXLEVEL_S, bits[11:8], don't trace anything happening
>>         * in secure state.
>> @@ -881,20 +892,10 @@ void etm4_config_trace_mode(struct etmv4_config *config)
>>
>>        addr_acc = config->addr_acc[ETM_DEFAULT_ADDR_COMP];
>>        /* clear default config */
>> -     addr_acc &= ~(ETM_EXLEVEL_NS_APP | ETM_EXLEVEL_NS_OS);
>> +     addr_acc &= ~(ETM_EXLEVEL_NS_APP | ETM_EXLEVEL_NS_OS |
>> +                     ETM_EXLEVEL_NS_HYP);
> 
> Indentation problems
> 
>>
>> -     /*
>> -      * EXLEVEL_NS, bits[15:12]
>> -      * The Exception levels are:
>> -      *   Bit[12] Exception level 0 - Application
>> -      *   Bit[13] Exception level 1 - OS
>> -      *   Bit[14] Exception level 2 - Hypervisor
>> -      *   Bit[15] Never implemented
>> -      */
>> -     if (mode & ETM_MODE_EXCL_KERN)
>> -             addr_acc |= ETM_EXLEVEL_NS_OS;
>> -     else
>> -             addr_acc |= ETM_EXLEVEL_NS_APP;
>> +     addr_acc |= etm4_get_ns_access_type(config);
>>
>>        config->addr_acc[ETM_DEFAULT_ADDR_COMP] = addr_acc;
>>        config->addr_acc[ETM_DEFAULT_ADDR_COMP + 1] = addr_acc;
> 
> I tested your patch on my side and it didn't break kernel space decoding.
> 
> Since it would have taken longer to ask you to respin than to make the changes
> myself, I applied your patch with the above modifications.
> 

Thank you for comments and corresponding fixes in the patch.

Tomasz
