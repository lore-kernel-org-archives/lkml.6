Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3202AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD872098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="bqPW4DKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD872098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeJLRb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:31:29 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:40672
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbeJLRb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVOuoo4JvCUvh7Tds4hArmaYRqrSSqI8zFEzBWhm4gM=;
 b=bqPW4DKN5QxuCjFAF9ApIuDylQkGWvR/eMUY5ik9DH30csSGjgQ5G4zXtZJGFRFxOEL3OIR26dNmVXFKIrkUqTOempbHDoLJTO+o9Mh7ToaTNh7c4hTxwbjt8qgF+5FynrLJ1cV+sepBY7xv1VQaQwSlBJJ1odBZTFO1AkwMAM4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
Received: from [10.2.206.68] (217.140.106.49) by
 AM6PR08MB3287.eurprd08.prod.outlook.com (2603:10a6:209:47::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Fri, 12 Oct 2018 09:59:40 +0000
Cc:     nd@arm.com, Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>, shuah <shuah@kernel.org>,
        carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>
Subject: Re: [RFC PATCH for 4.21 01/16] rseq/selftests: Add reference counter
 to coexist with glibc
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
 <20181010191936.7495-2-mathieu.desnoyers@efficios.com>
 <38596780-30f7-0763-0c17-7517dbf0bf59@arm.com>
 <1917048565.2402.1539270808972.JavaMail.zimbra@efficios.com>
 <3896e4f5-aab1-ae79-5360-088fd15ed380@arm.com>
 <1680616760.2469.1539275846360.JavaMail.zimbra@efficios.com>
 <f22ef029-2f30-6bd9-e46a-9e7b0a1e9225@arm.com>
 <254339058.2585.1539286978932.JavaMail.zimbra@efficios.com>
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=szabolcs.nagy@arm.com; keydata=
 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
Message-ID: <0dcd1e46-7007-3a99-4ada-f09ab66ab2d5@arm.com>
Date:   Fri, 12 Oct 2018 10:59:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <254339058.2585.1539286978932.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: CWLP265CA0343.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5a::19) To AM6PR08MB3287.eurprd08.prod.outlook.com
 (2603:10a6:209:47::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a360579-477f-4eae-7669-08d630296e66
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3287;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3287;3:hR25nKMhJrEml4irBqMmtekfXehIQ3kj1QfwnUAA472BNQxjxPKevbSnRbKsU4RMhmPwCOy1/55Yed6wkLQSSip50D2Of8yKoBxIq6goNOPMKLWKOr5Qp75KGTZ4ubT5f2cIP6JBx8Sfl5XUmrngDAG1hfErEJ6BsW2CLz1Qyi4uX6qLumh9iUFlJKtOZbAKMDZURGQsByaUCU2acO0ksuwVVAb597uJ2GGoGnifbzaG+kDEa0ElpHLalH0pb3GU;25:7ZqQenbKf0yf7ToFkwSFQnRm9joDoFZiT7Y3jAWJFwDx7L722/TajhtuIMZb/e34pB6f7QvCEx76vG90WPNx0hkCVKN4msEVfSlH1Ziti4CWA4hD+mmxzterFzRUshUmV6L5ZHnKGoAq9SVrrHBH+GhUn2MluhjRfLMT5eJqCBtHeM1i+6iOqniYu+/JOOK6R5X5VHEmvQ3WdJKE7TNBKNMIkLNWMjRez3q0/2wGJ/8jCREAHGwDa+e3ONSQ9tMpQsNYMzcGkHH/D/hTxtqelwQA2TL4tc4icS79lsfjVdLtxbxbVB+50sqTV9NpSG8BBEUHneaR1Ez3xuXtAl1rhw==;31:k2Nz9xbQlQeRqbPY4utYFFq1Ow/Z1w1i/bo3IcTDnPDv+h7QZb0wFviY7jaJ+LKcquYftqvxRbtjcARMjbVYCZPAZ094DUYZhJnom6kdFRbkQ4SkFj1BgASMlLZdJq63BkHQgC2T74fThpy2BcYhLOwgjck3uyv59TPgb/zyRsmZG4chFf6yqZbNpMfcNp1DIyAiFoTnYGCQuFP6Lpp/gH13sAcXwuDV5lUb8rhkH9M=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3287:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3287;20:v+hDXZqgTsquNYzHV9skcR0Zd0PG+49o7Ij9Duqzmdwcp9xD4MTNVxha0Web5+nDDSidU8NxdWZITJVoH/nyC6zy4CUbx6of/EKEgO5FlYx1OKK0WX00qr1yXKT6yf88oZ2XZmq40gPztkmLamdOljsE4dfRMIHVKhjLOyMfkWXOwXfP0erJVKfdGXT3KDBv+qwfttPnPWJ1DFknAKclUzUQHqKYa6c4JnfGvGpud2dE9ublr/8CTxqm6FUQBhqu4s+T7lnPPWlvNPwztbG/ch5/385OaOUoU68I4qOH1DuNySmbhGioJzFTxVd5+hnmRpINhP1oWcRkaf6MFv15i57hv7c05F62yawZG2DEX/I1IL+lNr7vuydGlvl8B+ns0IkGD4tkS6urSkDOc1vTNXK42Ca9fiS8RLAHbvVDFAU=;4:qSpnZSy4Bb9SyjykSTBGy+MDavq5qNQvpv2A+gVEcfgFUH4JCqIlOuDDAXIcRW9J5tF61V7dd0wAtN4BPJoDCZYobSz/yMHt2SyNMSTfcbRRsuGXy2PR8y1jAJsjEEBPijBpIUdD6TXDIcGxNTnI55GRHy4W+WXT1Wju9ijrwLGjvUE9eiW+PsltPtWQWA611WzW0/zFdyeycjEBzzVBVTqGXOwDqJAsKXDKrjn5buRHji99WJYsFo1TeJbM6GdO59lavKqN4PMMVnDdacC0GfoiAH33NTJDz6n8FmhzCHRgrpuWLWEEoAypuLU0zZ5IpGCJWDFfO1rpmgDf4xvANKNOs/SJMyvQw804FXNe6SdVRiR1RnSVGuPfIOTV+2St
X-Microsoft-Antispam-PRVS: <AM6PR08MB3287C24FDC0FB17B8D1D306EEDE20@AM6PR08MB3287.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(5213294742642)(278428928389397);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR08MB3287;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3287;
X-Forefront-PRVS: 0823A5777B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39860400002)(346002)(136003)(396003)(366004)(189003)(199004)(53546011)(305945005)(7736002)(39060400002)(316002)(7416002)(4326008)(106356001)(105586002)(93886005)(31686004)(72206003)(6246003)(36756003)(26005)(478600001)(77096007)(6916009)(16576012)(229853002)(186003)(16526019)(53936002)(2906002)(6486002)(81156014)(8676002)(81166006)(47776003)(8936002)(68736007)(65806001)(66066001)(65956001)(44832011)(50466002)(476003)(11346002)(3846002)(5660300001)(446003)(6116002)(2616005)(956004)(54906003)(76176011)(58126008)(230700001)(217873002)(25786009)(31696002)(65826007)(86362001)(386003)(52116002)(97736004)(23676004)(64126003)(52146003)(2486003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3287;H:[10.2.206.68];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjg3OzIzOjRXZWQvYlorQTgwTFJ6amYxTFk4SVFlb1Mw?=
 =?utf-8?B?WnN3SGdQZktPMXk3dnRJejBzWW1BZWZsaVJrS3F5KzI3RmFkdkZsUFlvckVW?=
 =?utf-8?B?blozT2Q1dllrNmdMMEo1SldCaTBaS1BiRFc4UUF0QUxrb3dxWWJzaytNNSs0?=
 =?utf-8?B?d0VpZVhlTTRXa0FXbG04aUJZaDFBL29GMHA3WXNCcUszUVlNMEhJVTJZdmFJ?=
 =?utf-8?B?WUxqWTBLY3UwYkNPNkdNQ3JFb0dGWkp3c3JoTXNqY2swWVdsVzhOTzMvWVhP?=
 =?utf-8?B?bjlGamVBaW5pQmJBcXkzeGdZbmFsZ0kwUHVSOEFvWG9DSWFRYnRKS1BpSVd0?=
 =?utf-8?B?a0pSa21BM2VvckNsLzlhSFhZSmRKOUU3cFVlc3VOQzhDRFRKTzVUc1pkMW1C?=
 =?utf-8?B?RDNyYUpJMGhUaUxCRXF2YStmNm5tdmtxaHMzVzF6Rnk2cU53TmRISGRCdDhZ?=
 =?utf-8?B?WEZLOWxlcWljdHpiUU1OYVJBdUsremZzQmh1cDJUNXM0T0QwaFJNK0s0ZWV5?=
 =?utf-8?B?T05UVlRQZUJSVEErcW5WTnUvbFV6eGplV3RrT2lEMERZREdmUlNOWFFoT0Zo?=
 =?utf-8?B?NmordXErNzFOVSs1MWJwd00vUXFxcVUvbktDVnJuUW5WaTdqbVRIRWVnVXdl?=
 =?utf-8?B?R2F1WGhVRW5YSzlZenJyNTVUbEJUNmFIblM2UkJPelVINGJMdGFhRno4ZnZx?=
 =?utf-8?B?RTF5TnB5MmdlNEJxbkw4RUc2ZWxqeVJBd0h2cjN3TzFZUS9kMjByaGtFcG1R?=
 =?utf-8?B?WVdCc0hjQ044L2NPSWZwOW1JcVRWbkhhcVN2Z3oya2tkR2F6RUlOa0YwNVk1?=
 =?utf-8?B?a2xTd3lpRmVaVTlLT2hBcUN4bjJLQnlYRTdtRWlwZHh5ejB2VElhUHhnVmR2?=
 =?utf-8?B?WkFJbFlaemtId21PYlBLRExDUlJqOEN4djVaaEQrem1ZanAwZzRNK3IxYk1M?=
 =?utf-8?B?TWdHN0E5RWN6Q2Zrd01MUG5TeEN4M2szKzlJaXN6c2xFZXJsSjNXTFRmdWht?=
 =?utf-8?B?WVIwaFFqVXNvanAxcE81MjVCTkh2VlZlQ0x6MlRlUTBKRHVQbjhNK0lJWGxh?=
 =?utf-8?B?QXNvY1ZOVWdIRnJEUW1kMXNJTnd1WEdNeWVzaVZWeUNmczhTUHFENmtuUytz?=
 =?utf-8?B?MTcyTmZuU1FlN09rQmtSQUpHSlFZMlM0eDZVdC9EcTNjV1B0VFhVQXlzMG1P?=
 =?utf-8?B?MnhzM05GUFJWNklGQmR4T2pkWXIraHRpUHRZbXpwcGRrRUFnRmZ4anVRenNU?=
 =?utf-8?B?SkFsdk5vbVdRTTN0L2w0SGI1YTBrbmFsYzdHVU9udTBkcS8yMDNCa0xFUEhs?=
 =?utf-8?B?UDJBLzNsMjBPUHNkbFZ1Zk8rb3U4MjNOMW1RRVE1U3NSKzlEVWZwaUx3WHAz?=
 =?utf-8?B?Zkt1cjM5UVNWSzlFdHNyaVBuY2FYaXh5bkFMTWpQZFhjdjEzWFlpZFdsMFl5?=
 =?utf-8?B?MWd1elkvY2lnc2svN0NiMzlpUDdWQlh3TGYxQzN1UEorNjNid2lkdE1uaVFk?=
 =?utf-8?B?VkNWSnBCc29JenVUWXl5MjNwdnU4RDloQm85Yk0zN3N3SG1ZeFVaWDY4Q0Z5?=
 =?utf-8?B?emkyOWZPbnYvQTN2cEF0Y3NidkdMZkdQTTVnTkttc1VtRU9TWkRvNUxuTTZw?=
 =?utf-8?B?M2s4aldWUFoxc2gzQTUxM3IvZjZ4cERpUEVUc1creTBwWnFjTkNTTUV1QVVs?=
 =?utf-8?B?cU9JcGVES05TZkkxL1YwRzF5MjNYMkRpYmVvTFJvYVdrQ0N4dFd3TVVDZWpF?=
 =?utf-8?B?MGFIWnJqOHo3cHYwVVV2NnpmWEFMdFVIanRHSGNndFF0L1lpWnE2TFJhUHc2?=
 =?utf-8?B?bHlreVdYRWpQcC9MU3JQcjZEWFppT25ZbWpINXN0RFIzejhnTjc0MmVrYS84?=
 =?utf-8?B?dUNCT1ZUQnVXeTc5OXN5bTVRTys2WWJUZFRyVCt6TFh3eXZQWWRTTXpXQ29m?=
 =?utf-8?B?QnFrTjFHVGJSWmdUVFY1OE0zcmxDZnRxZlYwcEhDNS9JU0VFVlU4WFFJVUdj?=
 =?utf-8?B?dWlsMFhYRkVJMk9lQ0ViSm1tejg3RFZ4Qk5YUDJUT3lnbTRwenlqcG5qc3V4?=
 =?utf-8?Q?AbF/UgNlgpPyvvdCFnRB3R0Va?=
X-Microsoft-Antispam-Message-Info: GNjfZHgFZl2wduTXQy0abAYpC4zPItU21hdBTmR4w+PVbM1WWI/dixJWJCik2/zJYAtvNhNGCipmChHZsXO/PP66FPCk2Q4xsKImrJFR+28ifmatYgEBBPzSMSztbFZFRhjY0Rzb2Bq2d2krOROJYMSgdsmnPtBwucMuh0Xwx8Oz9fjLA56+oqkwgovys4llr7XqcNHArf7V+eFaCS/WlfPjMRsmXqWDeUIbq96snbP+XNcroaJYpuRX5p8MN4Z9Pj4ihwzOT+PqUrW1zLmRdWtIplSc8S3RQW1vT3FYhFb/d5ovLfEJWxFoAFhq+yVlV4Lyk+GAXdLTgivqjUvbfnQfOZEQNWhoWDx5ozjJOAQ=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3287;6:FTRXTFssVJA92PeNRdx3D4MFgGaxa8VaQJSgrf8F07N5SmOt+WLGJbDqYyQ6PTWVdXgh96fnXFOFsBk78G3UshbLGGC99J/CAlE0SExnjPiXKcD9c1AUAXIq/s57dLj23iTkGHZ/DZHh1cDSmSvXhRGXhcZwx7oVfe2RsT1y6UvIs2AZHMU5CiKIAxlgFGfiBAum2zXyKLZodBiNEl7VuF24eexPTlE8Bt6viz0y0BKZpj37OTHaQqgoWPNeidLS9swyNkgTFrlHK1SK0o/xzPCvYLIKYx8Pz24jfUtK1c78G34cNfkziCOle60Tu5NITVdnMQWxN6lMCGEzTiQZ0xczkNYlFEOVtyEOoE83JhwAv34WnbILx1QWbsUo/IXe2X1q6CkkdC3vmNL1y05gvdZdVYYrf2VCaIKzJBcMOnCSwhoNjoIMzCsJG4nRHwIV8SOIvAsyethhG7jklbVjkA==;5:ohqURdK0K7CjEaqKX25QKlFXEhHCArwd4PQQ/RpZbXpDlwvZeaSo653oEc11HvWnl7jgeYTpj8/B2BeLlFQP9a8Pvxl0I056/pH3UiofxjCsU2Znuhg6Rl9s2d+SzQFEZJXl0+C+uV7ETawE2g9aEakOiMSC1RP6g3/wdYiJPEs=;7:SmcFpEOo9Rlpe9ADLCt7M0cfU9BZNOk7mfm4PD9xJcRQLQ7N1aV2gCe6hhFzzVKe2Kkq0N3UmmK3Z4m7MwOG1Cy5AHA3yYg1w1zJsT4YHpi1LIVC3ApvgUGjTw/GcJAb2d0KujaL+f1VGRKKher7oFnaNFIaDy30mZPmfNvEBoAbsAxam4PpA/8Id8bbbO4qSQGZGi114KekFAtMKaG/1Klw6XjzDgdIpemWQWl5264godA4OtojgQ3MunbOuK7h
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2018 09:59:40.9754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a360579-477f-4eae-7669-08d630296e66
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3287
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/18 20:42, Mathieu Desnoyers wrote:
> ----- On Oct 11, 2018, at 1:04 PM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:
> 
>> On 11/10/18 17:37, Mathieu Desnoyers wrote:
>>> ----- On Oct 11, 2018, at 12:20 PM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:
>>>> On 11/10/18 16:13, Mathieu Desnoyers wrote:
>>>>> ----- On Oct 11, 2018, at 6:37 AM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:
>>>>>> On 10/10/18 20:19, Mathieu Desnoyers wrote:
>>>>>>> +__attribute__((visibility("hidden"))) __thread
>>>>>>> +volatile struct libc_rseq __lib_rseq_abi = {
>>>>>> ...
>>>> but it's in a magic struct that's called "abi" which is confusing,
>>>> the counter is not abi, it's in a hidden object.
>>>
>>> No, it is really an ABI between user-space apps/libs. It's not meant to be
>>> hidden. glibc implements its own register/unregister functions (it does not
>>> link against librseq). librseq exposes register/unregister functions as public
>>> APIs. Those also use the refcount. I also plan to have existing libraries, e.g.
>>> liblttng-ust and possibly liburcu flavors, implement the
>>> registration/unregistration and refcount handling on their own, so we don't
>>> have to add a requirement on additional linking on librseq for pre-existing
>>> libraries.
>>>
>>> So that refcount is not an ABI between kernel and user-space, but it's a
>>> user-space ABI nevertheless (between program and shared objects).
>>>
>>
>> if that's what you want, then your declaration is wrong.
>> the object should not have hidden visibility.
> 
> Actually, if we look closer into my patch, it defines two symbols,
> one of which is an alias:
> 
> __attribute__((visibility("hidden"))) __thread
> volatile struct libc_rseq __lib_rseq_abi = {
>         .cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
> };
> 
> extern __attribute__((weak, alias("__lib_rseq_abi"))) __thread
> volatile struct rseq __rseq_abi;
> 
> Note that the public __rseq_abi symbol is weak but does not have
> hidden visibility. I do this to ensure I don't get prototype
> mismatch for __rseq_abi between rseq.c and rseq.h (it is required
> to be a struct rseq by rseq.h), but I want the space to hold the
> extra refcount field present in struct libc_rseq.
> 

but that's wrong: the weak symbol might get resolved to
a different object in another module, while you increment
a local refcounter, so there is no coordination between
userspace components.

this was the reason for my first question in my original mail,
as soon as i saw the local counter i suspected this is broken.

and "assume there is an extra counter field" is not
acceptable as user space abi, if the counter is relevant
across modules then expose the entire struct.

>> either the struct should be public abi (extern tls
>> symbol) or the register/unregister functions should
>> be public abi (so when multiple implementations are
>> present in the same process only one of them will
>> provide definition for the public abi symbol and
>> thus there will be one refcounter).
> 
> Those are two possible solutions, indeed. Considering that
> we already need to expose the __rseq_abi symbol as a public
> ABI in a way that ensures that multiple implementations
> in a same process end up only using one of them, it seems
> straightforward to simply extend that structure and hold the
> refcount there, rather than having two extra ABI symbols
> (register/unregister functions).
> 
> One very appropriate question here is whether we want to
> expose the layout of struct libc_rseq (which includes the
> refcount) in a public header file, and if so, which project
> should hold it ? Or do we just want to document the layout
> of this ABI so projects can define the structure layout
> internally ? As my implementation currently stands, I have
> the following structure duplicated into rseq selftests,
> librseq, and glibc:
> 

"not exposed" and "the counter is abi" together is not
useful, either you want coordination in user-space or
not, that decision should imply the userspace abi/api
(e.g. adding a counter to the user-space struct).

it is true that only modules that implement registration
need to know about the counter and normal users don't,
but if you want any coordination then the layout must
be fixed and that should be exposed somewhere to avoid
breakage.

(i think ideally the api would be controlled by functions
and not object symbols with magic layout, but the rseq
design is already full of such magic. and i think it's
better to do the registration in libc only without
coordination but that might not be practical if users
want it now)

> /*
>  * linux/rseq.h defines struct rseq as aligned on 32 bytes. The kernel ABI
>  * size is 20 bytes. For support of multiple rseq users within a process,
>  * user-space defines an extra 4 bytes field as a reference count, for a
>  * total of 24 bytes.
>  */
> struct libc_rseq {
>         /* kernel-userspace ABI. */
>         __u32 cpu_id_start;
>         __u32 cpu_id;
>         __u64 rseq_cs;
>         __u32 flags;
>         /* user-space ABI. */
>         __u32 refcount;
> } __attribute__((aligned(4 * sizeof(__u64))));
> 
> That duplicated structure only needs to be present in early-adopter
> applications/libraries. Those linking on librseq or relying on newer
> glibc to register rseq don't need to know about this extended layout:
> all they need to care about is the layout of struct rseq (without the
> added refcount). 

please decide if you want multiple libraries to
be able to register rseq and coordinate or not
and document that decision in the public api.
