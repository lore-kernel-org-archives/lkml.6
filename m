Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3C036C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AB2208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="FX/LUSX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AB2208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbeFNGrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:47:14 -0400
Received: from mail-he1eur01on0059.outbound.protection.outlook.com ([104.47.0.59]:7296
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752813AbeFNGrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUV7yYjRiPo6+n40Nky1K8AsKRLhkajgZtqhjfzjga0=;
 b=FX/LUSX80k8SRFm6+XDQjYvmUdia8K+zNY/xmfki6BN6cQVGLQja6QST+u66z/gbgSaR7bmdJN8t64dOUzqRuE1xvL7Civ+IoxMsIJKAEB89krNIuXYGf8TVXPty127ysDKm6ppLaSjEXtPzx/3VfBVvZFrc23mTF01Kd/rxW4M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 VI1PR0302MB3213.eurprd03.prod.outlook.com (2603:10a6:803:18::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Thu, 14 Jun
 2018 06:47:06 +0000
Subject: Re: [PATCH v3 0/9] xen: dma-buf support for grant device
To:     jgross@suse.com, boris.ostrovsky@oracle.com
Cc:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        konrad.wilk@oracle.com, daniel.vetter@intel.com,
        dongwon.kim@intel.com, matthew.d.roper@intel.com
References: <20180612134200.17456-1-andr2000@gmail.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <1088db4b-cf75-817f-2112-41b96006cd3d@epam.com>
Date:   Thu, 14 Jun 2018 09:47:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612134200.17456-1-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM5PR0402CA0014.eurprd04.prod.outlook.com
 (2603:10a6:203:90::24) To VI1PR0302MB3213.eurprd03.prod.outlook.com
 (2603:10a6:803:18::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c5defd0-5cb6-4fe8-5659-08d5d1c2a5b8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0302MB3213;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3213;3:568TVt4UsjNa9OtUmncsHNdA2F8gInSuezv5oVSrJI8wj4pvTYK3i/PQfIG154k1vTwpduHmC4EI7oKgDnADQ3K4CmLqUA7AyuPA6pQWp0dWoD/4GH7tWD9C8NU48ja/2ByjdQYLKPRHCLDlXhgUlvWxudpikd3Z3YHl8tiq834dNtIvb1R4s22LHctO4bp2xcTULyQSLjJhUYzGxSkO50b06Jumg4ZBgwNYpJiyir9IuxaWGJrB37IqbGNbgBp9;25:1guj9rxKFJSY0L2j09DKUygFfXfxxoPPLKPhNNVkbq3vnLjZl9WN1pzscpXn1UJlL+HmqS2cb2MdKaSGcOi8IiyF1YCTqPtwr+/7zDn/f78YW8wVPqtBz5dOOWumYA7LU58sUkjrKeWDtS4bC8eZ30C6DEOAty47jmsZLh9SARaqfrRvQGBCIRPd9VxgLl1GVRipS94igVZYh3pIFMmU4DYOvlSWIQn2IBaDmaGNne860iNo0iQKIvyNKhQz+98/Ombx8wxheirEBHlu4V0I1BipQ12G1bPrbMz3Cx2d99J14LSW6H5EdwYDBFt3E5jy3nnySZAO0spfBHV0tPnYZA==;31:JeTjr4UZDWrj7JYUg5sgYo2qxmDBwKvWjNabkoBrsn3QNs5Is+c3lNwBhZkM0CkiyjKy6jNNF5A2GsVfv0KBJi6HysPCeOofSz4Rgc7eCgas/yn6+S1r+Ya7ysr+Ch95+IU1xnuWXhakFxGPaQnCzSSLD9fzPnAimfSHJo4zt/1nrB4yt6YUixecWXfEJigXWGn1g2FrUgXUflqhplVFI11dAEsEcFifSldEPwO4PXs=
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3213:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3213;20:lp3z6LxmnMHLTA4w57yhvhSZv9wUYY7V2wQVKT6ksHjE9ykUXMfaWswQPk1QOWx6GdVXhMhinU7d8CTnV+3K+Wx5cXmcHiU95B86hLeXpQNXB7GKwQdl8XmA/jAIk4HArfzVgaLMhSoTKud1nbA8p849SgIRIrPnEtyg/MEEClLeJq3IFkUtDxSv5FVAjmQ3Dl3MeSWwGT+XqMVq6Q4RgfGko5zuHt5ta6Cm4s+PW05Y4b7IDHb/wSNZ4nqIokXOSMx9cBN4e9OPXB0tuWE2BrNOQ49G6hWwcNgYjv8OcLmTYHIb/zDZdjOlHHy51xZYF4lOhuMKzsfs95KcwM9ErrgP8sz1nyFDVN8DRsxb5PM+2Ee6CTOxKdK+0RVdukibU6r+sAaYFhOOluA7vC3O/IOXYuZwHVNtl5ppzJ2eEGWccHZkuY3854IPN4LsJdh4ZR3bmEAdCUXo4rj1iUE66NnJmTQFo0wcBK6IniW2wyR7uA+brJ/t4w0PmupDs6T5;4:2aHLzFF7fpmo2sjwuGieuI4gsJgTNllxXzZ10C8IG4XKtfi6FtifvWxQXkI5mSo7ZXS03TeAVgEzEd1XgUmPhjGr2LtggKniYc+v6EmNY1cYJeOQTcRehLTYo/q4qrVvP0K7BuhCOgRHOZ/zJyCNGg/QztW+W34i+GbPpOrzXUf3ADZFDHURP/7qguDZBN/otW5gJE2cJyxSyR/yJZPNnVysZepwI4fCjgmaG6WSklc2KBQJropCpJPJDDWkC6VPI7b0sDW56Vv2cwGCPZjzrD526sJ9TzvECOYs+JabIpuuJUfcbCmQZ5ai8Pe/PFro
X-Microsoft-Antispam-PRVS: <VI1PR0302MB32139EBA601406A36259A25FE77D0@VI1PR0302MB3213.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0302MB3213;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0302MB3213;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(346002)(376002)(39380400002)(396003)(39860400002)(189003)(199004)(6486002)(64126003)(230700001)(65826007)(6246003)(53936002)(3846002)(7736002)(6116002)(86362001)(58126008)(80792005)(6666003)(97736004)(67846002)(305945005)(229853002)(7416002)(68736007)(5660300001)(50466002)(11346002)(81166006)(26005)(486006)(31686004)(16576012)(446003)(47776003)(8676002)(2616005)(476003)(65956001)(6306002)(106356001)(39060400002)(956004)(66066001)(8936002)(65806001)(2906002)(31696002)(478600001)(4326008)(16526019)(25786009)(966005)(186003)(77096007)(36756003)(72206003)(316002)(55236004)(2486003)(105586002)(52146003)(52116002)(386003)(76176011)(23676004)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0302MB3213;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAzMDJNQjMyMTM7MjM6U3NmWGgycXpLRGpOM244QmYzc2U4aUJC?=
 =?utf-8?B?U2F5WkNwQlBXVm9IVkhGUXNHUFRnWWRIa3d6ZnJNQVJMejEvSFFQSWtndEtJ?=
 =?utf-8?B?c2pYSjBMUmJEV2plMGI3MllNZGFkOVpNUDhHbFlucVN0ck4wbWF5ZnpYQldE?=
 =?utf-8?B?bHNCZ1Z3Z3lxeGZzTUlrTDJNRkRaSklTcFU0U241Z0pWTEY2bUh1SDUwVmVW?=
 =?utf-8?B?Q0FUTDBSSEhITHZpUUwvSFJFQkNSTXZxb1ZOZnVSYVJMdHpyUnJCMXYvbEdM?=
 =?utf-8?B?UEFVOVZYNGRVaVc5aGdzVlRLMXRYamJDMld5ZFZxdGR5dkxNbWdVY2JHck4y?=
 =?utf-8?B?ak9BNnB2dCtqU1dGeU9JMFNmbHpveCs1WGVXQkdTbjRmYW9leTgwbnhsbUR2?=
 =?utf-8?B?MzVDRXl3VHhKSnZsd3RBdTFFczlWZW1XL2dIYlpKYThWWWFmUDBEcWZZR2ZG?=
 =?utf-8?B?c0xoQVB2Rlk3c1MwZzlOb3ZGL1ZKRUhHZlo4RWc1clZIQzFYQ01DQTdxditF?=
 =?utf-8?B?U2puSm5SQnZmMWxYaDdzSWM2VWI0dzJxbkphV013S2RseXFQSzd6aHNqK3Q5?=
 =?utf-8?B?azJleE1oejk5TS9xRk51VG81KzZjWTJkWFNiMW5FeGxNeTJiaUM2L1VSSWF1?=
 =?utf-8?B?MEdRZVRvOVV0TFdGZHhBU1l2c2Q5Y2xxd3JKSW5HVXFUZUZDWVNURktrTmNH?=
 =?utf-8?B?T0ZBc3U0ZXBmY1VKMVJjczJWUDZ1N2NaSGhmMmx6VjFoS1ZXNCtERml3aTdy?=
 =?utf-8?B?a3ZNeHBlTDQxaTJacGpnQzkxSHA2WEYweEtaQ1hvcHdMbjR2aHhOVC83M0pn?=
 =?utf-8?B?dGtad1RYTmhkRGN1MU9oZkhzS1hvaFpWcm1BVVhBNmx1VWdnSUloSmVNTFJo?=
 =?utf-8?B?K1VnaXZieDdwUzkwMDdwU0FMbktPbG9EK016YkN3MHlPR2lWRkp1VWRCZVdn?=
 =?utf-8?B?QjBVa1pESTdWcEtZem52Tk1DOUNMcWVyUFJvclpMck1YaEhTaTA2QXlYSnFi?=
 =?utf-8?B?VWFtMEVtMU0zaDFzSFAyUXdOa3FROVNEcFg4c0lmKzNUMzRWc0oyMlQvUEV1?=
 =?utf-8?B?QUhUZ0Q5L2loUExtN0tVRkhQbEdVbTVPWFNOOUoyMHlhbzVUMHVIeXplU2VI?=
 =?utf-8?B?MUxSQTY5Q21FZU9EM0lMazhaeXpGanB1L2VweVNadHdCNU5zVUpCeGdvSmMy?=
 =?utf-8?B?NllqaXZYNDVPYU4zU3FkVVFIWGtMd1VEcGxUMVJoSUt6VWk5MStOZ0ZjamEx?=
 =?utf-8?B?VSsxKzhEeWI3VXFDRkZrK3h1L3BTK1o1ZDFGMG8rbXhKdkM5ODd2NkxDdU0v?=
 =?utf-8?B?UFpsZVcvTVNURVFTYSttZTJhc0dzclNHQmR4WHgyOTFXZWlYejdSc0pJVnR0?=
 =?utf-8?B?eWhrZm5rR08wN3pYSmovNUdRYmRkb2RRSHpiODU4ZHJpWWtocWsyT1pWU1F4?=
 =?utf-8?B?b1IwTXZaRmphSVNKYk9JdWlsNDI0aXVtT3ZzM05HQnNRUlJsWWhvdzZtVHMw?=
 =?utf-8?B?ZGZhQXNYRjJQcXVvQUhDMFVrT1VMaE5kTG9jbkhTaTd0SmxwSjZNUEdQSlhx?=
 =?utf-8?B?OExVZ3dHWXJvei8vczYwODFmWmFFeXBGUHhadFowcWRMTTdiZStURGt1c2dR?=
 =?utf-8?B?UEdZcEN0eXhjY1A5QS9rOStlSlc2TUV3M3Q1YkhFdWhBUkVnenBERUlPWStp?=
 =?utf-8?B?OHhjLzR6TE1QSjZDRXV6VWJpOHF1QW1GVE4waEg1eVUxSVh3eTlaZ3NOL3kr?=
 =?utf-8?B?WEw1dHdiTE9nQnRTMEhOcjR5QmFoVk1UdnJ0K3hVSlNBb04xempXVW13MnN1?=
 =?utf-8?B?TFN6YnVXZFhFQlNtTSt2Ynl1KzdWS3ZEdVZqcFZKVGRvZ21YNHJUOWRNSUNy?=
 =?utf-8?B?anoydWFxcG1BdDB1TGJFcTJ1WUZTYTUyZVhvSkJvN2lPWTVlQ2hZWm9IMmdZ?=
 =?utf-8?B?R0lRTUhDUHlkWVd3VWhJZXBSdmlRZ24yYnhYeGxoSnZnTzViL0hya2E2TzlQ?=
 =?utf-8?B?dU9yOVNGV1l5M3JOWmllNEF6MGRYYUxuaEh4eGZHYkdaZ1dFL3VSaG1MQmJp?=
 =?utf-8?Q?v0imG4eZXcI+MFNXc43f+/dXTIC?=
X-Microsoft-Antispam-Message-Info: zrSaTfokFdclY0lODH1JvkfE02NJcgVfF1LocrQcglt3wsP+hpEyE3m5XyKEQGfOH0hB3SibdywKvvez3IjzUParzEtRhvGWegGGULA4wS5fJptiFXnefEMNy4AmYRtO4G3JIKkS055MRIVPWyfCERjiwixeTeZIWXQbF7NitGMm3G/hj2k9Lvhvlo0YIYOl
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3213;6:3dL+RM+GFvmpaLXAErzzNHBbCX6A2aLKVsWQOEK0U3MDC3CjhN+cLhsAWTH7JR73iURfk28MEPRJ4SWhaIpcVt0yPEeovAbLlBvXFxIedvlQtyLOK4yEPNRhJSJn9oDV926hhEzf8wNMpo6Mz4l0A3PsaLuh3k5nWqWJTQWN5tDgWDyLFWoJ80z8yu1pHuPEAI0TkJSeYPLquL/YGa0ouXo7FpHhvibEwYRZzJ3QzMm8+kXMVFKqPJOWRZg04HLXBMubvwm0UI5n6y13VrTQef1VBwW6kGKsEKEwfZiFevBi2y4GhO8RRKIb8xjmfeReLdhRVIHsmYbOIoxAfBsWB489+Imj9sP25ICMBLGVi0X8y1XFdnXOWMiCua02QbcCA+8ea5rzvi+Ykma+ySomhdoYOePBVZT3QP8b91uUvXINnwBA6Ev62SfOgoWg7V2odYQ8MeiNExna6TT6j/rOmA==;5:0cYH+YvJQwP+8O6bTqkJECrGt2hjZ0UuJfJsZuem3+rJ36PgPaVsGZKBomeUhqS2bVik7hdc9TDyymHLHL103K8LAC2PpxYqvnlgSmXVcI14BClpnunjSySUAKiVFfbcBvZTrsTIq/gmkYqKO1ds0YQjtwHP3PX0cTnK1AYl2e4=;24:mmzJ1LJwgHIFgLJ9RfMhrtsERSX310d9s8F5zZ5HjXklFJkTl415HmOHc0q4WGtB0QwPPU1RIdz3ZeWJZMlxL6KgC1GSt8NaLw2i6PAqE4k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3213;7:jgmkbRT/O2yTNJB7klMcUHf0dvatTCWQnhw6RnTEqzJP+5lfzOvf4Jem9nrHq4l4wgsDXnfjOAsrJviKyB8RCjS+h67wHxBktjQ05uk4Bg7hJLtovArKKNd45AANlt9iJfVEjAT0dR53TWK1anG8BibJLzxTChy13oz77TaSwNQDSXSFTuQozQmbmgW2WqM33uWQhi2IU3wZlN31RBn5WkPHbuDtGNsphX7yUNxeR3P3Zci7F/LsUkU7e+Vq2OoV
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 06:47:06.6347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5defd0-5cb6-4fe8-5659-08d5d1c2a5b8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Boris!

It seems that I have resolved all the issues now which
were mainly cleanup and code movement and 5 of 9 patches
already have r-b's. Do you, as the primary reviewer of the
series, think I can push (hopefully) the final version
of the patches? Just in case you want to look at v4 it is at [1].

Thank you,
Oleksandr

[1] 
https://github.com/andr2000/linux/commits/xen_tip_linux_next_xen_dma_buf_v4
