Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDD4C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC8920684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="HTXtFz09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC8920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbeGSSno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:44 -0400
Received: from mail-eopbgr680082.outbound.protection.outlook.com ([40.107.68.82]:23808
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732059AbeGSSnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0pfngb2Ws9H2vLASxxfKqyrZq0vekjzqPd7jnvWzRo=;
 b=HTXtFz092pkB5ID2YHVOkFEeXeYKy2Ot7jsy8pkYlds/9BFTlvHWBVWV9n+dk3bzb8SyVZjb1qe9P61AB/6dvkzIhqhfWuNgrWd4IZCQxXdKVbLUjdEC1gmfeR6mBbp4Jdb5UGXffx47Y0I0nvC1W3ruITQEPy2TG+4aTI2qOUY=
Received: from DM5PR07CA0067.namprd07.prod.outlook.com (2603:10b6:4:ad::32) by
 BN7PR07MB4706.namprd07.prod.outlook.com (2603:10b6:406:f1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Thu, 19 Jul 2018 17:59:20 +0000
Received: from DM3NAM05FT048.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::202) by DM5PR07CA0067.outlook.office365.com
 (2603:10b6:4:ad::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:20 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT048.mail.protection.outlook.com (10.152.98.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:19 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxAS3019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:18 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:28 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:28 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxCis005810;
        Thu, 19 Jul 2018 18:59:12 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxCiS005809;
        Thu, 19 Jul 2018 18:59:12 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 13/31] usb: usbssp: addec procedure for handlin Port Status Change events.
Date:   Thu, 19 Jul 2018 18:57:46 +0100
Message-ID: <1532023084-28083-14-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(36092001)(45074003)(199004)(189003)(6666003)(476003)(5024004)(426003)(2616005)(11346002)(50466002)(50226002)(186003)(2906002)(486006)(1671002)(478600001)(87636003)(4720700003)(26826003)(106466001)(126002)(47776003)(14444005)(336012)(105596002)(109986005)(2870700001)(356003)(305945005)(4326008)(23676004)(36756003)(446003)(107886003)(7636002)(86362001)(19627235002)(42186006)(5820100001)(8936002)(76176011)(8676002)(54906003)(316002)(26005)(246002)(5660300001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4706;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT048;1:eBdMtmXgHMbbvN7qjO4XkQqPQzH5k+G7dT3cwR6huLZ4+hzQ4vzASY6OAn4PEhR7JwaieVDC8hDapkovUwiJjpg0g6MaNZzfMu1zUFUDk3PruAfmvlONBVCHuehgXgEv
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9d67e44-9345-4b41-daf9-08d5eda15a13
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN7PR07MB4706;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4706;3:HziavIxcmbIAwLvZGk573O1gvSIZ/NzDzhfWBMMjVC5Pzds4HVgRZo3AP93tZhtEYp9EGALU07eZUoy/IQzY8okScJqMcbXNIDSrz/bE3ICH6wIMcANWYCsNC7f//UyOzWB0HAkDgehpfq44dIKkTr8/1xeffEu7o9+cB6L8RawOIen0buCRRgOBcFRs9Am2bV6D+ID2NDbq/R64yT4OZLvk2Lss/LFRmSdkjH/8Qn3R/6aQf5AYBXFXVvRAFCG80rHvcOZdczuHvbmFQLU6lM9sbrIxRISerVefCxmgJm+KV3+w0XV475vho2/wOeWGYQbs93z6AEA95hIusO52Vi61eGSk1WHUEIqLH6A22Ug=;25:Rebr6WjJJFAgQcIUoF9/ICS++PosbVrJTFYo+eT8dLCeeqfbRar+1NA5+QHq/4A38WGCYQTzTcfADVJy+Ax1X58SM6nfNqYQPxIqh+eePshx8BE2dReBVHFW4BeouoNjEf3KoRw6esaw8Fp2P7tnSgp11+8gqLMuup29xeW+ydEXwM6AIg7ectuV4vXOQjCzUn6Gr4+IcaXDnNxkk578nWr6Mi+lfR8HSSVaMiZ4v7JXCeoX12vYkwPS3q4DzpuPE+lzpcWYB8/NswR0w4uDYxDE+RERl3a3+NkmwZfn/VuEhcEPN1BVyPVqEjs12bPVvqxxbaF/BaaKcw1thWlSig==
X-MS-TrafficTypeDiagnostic: BN7PR07MB4706:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4706;31:VSXyjjvn2lDPeEugbeG3RgMoTxPSB3Xd7UknD0WAUKpKCOqt/+QSRoepmmxV7vfZtacFppsxuCcA2tbm36rdU/qfv2oUhF8Zx+CNOIx0JiwE3ly3WO0j9ODU5cItlVIE0CpDVxSkwyvqabHxDIvM+wFobxkmsP73CTvuYgxnB6hHzQDtp/gQ3svrr6G3AfBMI8p5cfpvc4EUoARPeFeAsxUSwrfx7Zh5Q+A60+fZAlg=;20:Xe30QAn6DoOzm04RHE/1gkmWozoToyRkdwccsNmf9w+SCIy9siyo9KkEPM/k6XaC1pXXNzHMZJSkZ1030d7wTB5fzC/VVOJpIRnFpf0k34s5A2mVIitdbjbQJ6nYDmtIEt0S4vUEb3q55tFESBnbJzWRukwzmMBNC/FDmg6rb0Jyanu8BNOwP4sInrsY3a52gXtxWXA8/FijaKHfl9j6xU3s//NOKPaNtAtyzHPiAxR7Y1vmx7rjqJHgpKwqJ1tN+aROaGwfOC5QJd1mMA0bBUB7r7MQltE0UjBJ9LCYKCpj/jhDq6OIhMdPY3fnOim4TxeoQb1e6jXJ2Of7o9jWCbxcngM0j7L98xzMsz0puyUOHtqmT/81VIikTfVQUFBXld7oVmAMJBK061mtfenzTVG3LWkuppeXPN0/btTE6Lee6NqGjRWCl5rXrnrAEXe8tUy2S1isb0vWX1g4OwnNOxtjCK/+ZiKV7egDaY0y37zJMWwRhhlmNAbZBrleJQqj
X-Microsoft-Antispam-PRVS: <BN7PR07MB47067F9D2E1C84D9566FAA4BDD520@BN7PR07MB4706.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93003095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4706;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4706;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4706;4:OY65f76pcX0tKLZCWayoZqLw+ZFBfDgr3hGoCMhySCNg1BR3bXqypXHHaWbWj5TL9xqSP756yOEAnGx62+Xlp9tDLdaO0MCh1KoHIljwJ8hcMNaQpv8fuptHp1TD09xovq4q5U3DI/YV5xlPBEPgYV4P5KzRzypkQyxKxIwg4QVyfgxTgiqZWcLyStGCTL5zjxXmHV327pOohGHQcOiHrNX5Y6YxUeH4fkcUiRRDroTSUim59ylNT+ez+Yu0hYlBOqRuPJh2wQUOyY1imVKviE0evTtQiTe/RPEynPBgp1aaEuDn27UY9DA+6RzEFhpZMURlv0o0DgjLj6mIE3kIk6bB4mrWgtqUjgGCfqnu8Q0=
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjA3TUI0NzA2OzIzOnNxbVhNQ21lTXdiekdUeEtjOG5mV0ZLM1JM?=
 =?utf-8?B?UTdLTVNMSGlxeVR2L2RBd0U2cGh1S3p1T1dVTFgyVVVCbGhzVDdLMGRkM2Ev?=
 =?utf-8?B?Rk9ScytNZkJiWG0yWG4xY2k0eUlLZnhaRC9jeUpmcnpRVHZlUTVvOFNGeTkz?=
 =?utf-8?B?Ry93aS9sREE2MDdZY3FaeFFqRlJISVJuYzU1T0J5SmdiTEIzTlNzRE5uU0FU?=
 =?utf-8?B?dmtFNlg3L2svK3J6aGM1dlY2Tml1WjU2ZVRBQTdwRlh5U0Fpd3lIalpHc3hh?=
 =?utf-8?B?c1JsdDNLeUlUTCtjNndQYlJhNFdBWkgwZlZlWlNLQWNYcHB1YkdabTQxSWEr?=
 =?utf-8?B?dVVFMnlXd25aRVBTek1yU1hjZGhBZzFNY3laTjI5YVlTOHdDVjBsQmo3eHdP?=
 =?utf-8?B?cGhMK2NreGpxRnNMNnpnMnBtOEF2MkpaL1N0dWJ4eFRWRlA2U3M3ZWE1dnk0?=
 =?utf-8?B?M2IvWUZmM2VSZk1FQVExK3ZUdE9Hc2E1NEhRYUlBdG04Z3EyRzY3UUMwRjly?=
 =?utf-8?B?SytlWk1zYVZTSWdyM2RjZ3ZQYTBmYmpWeUl6K3hDRkQ3NER4dUxNMTNhR29q?=
 =?utf-8?B?SEFEMU52ZkkwZGtHRlp3dTNNb0lZUi92NHFWMDRXL2U2SDZiazVlYTRDcjdI?=
 =?utf-8?B?eURZS3RnanR2RWYrVXhoZFRTQUF0NDdUS3hFMEdRQnhHMTJTbzUreW1xMHha?=
 =?utf-8?B?VnBrN1lGYXJOVXk0OHV4d0ZzaTJGaTMzSnlBU2pnVEpLdFV6bitNOFFTR1Zw?=
 =?utf-8?B?ZmJucjQ5REZRNkNBZ3dWNWpjOGFYd3AwZ1d5Z0RpT0diVFVGVmpVa2I4STli?=
 =?utf-8?B?UHhpNEVmNU5uN0k3a1M0ekljK2FpS2tuUGNTM0JSVjZSV0NhdnArMGMxb3ZJ?=
 =?utf-8?B?MWRtZ05QeHNua3N1NmJIa242WGpkQ2ZkNzY5QWtYK2tSU1Q3Y1VtM0V6UFFJ?=
 =?utf-8?B?SkI3ekl0YVM1QkZZUTEyQ0tTSEkvMTF4YzYxdEZCM3VMQzVPRG5ZWlRRUmFS?=
 =?utf-8?B?LzhQL2pSR0pCV3NYOTQzYklWK0tmMnRNL2lpcStrbVdtZGJHWlVOYzFWTzRS?=
 =?utf-8?B?ZWNDNEVuaHBxSlI3QzBsUHhBaFRGMlZCWGVWTXMzY3ptUm9NbTYveXZIaWNP?=
 =?utf-8?B?NkNpQ0ZXL1YzV2hxeUlaVG5CSmlTMUhlcGJITlUzVXBmTjNVQ1ZpdXJBWkVN?=
 =?utf-8?B?TjJmNkczendNV2IreVYyUEpLY2p0RzdwTHBaUTRpcU1NQzJFSE1zZitjQXpO?=
 =?utf-8?B?b09QWTZESFJ4Sm1OWEM3Z0NjU0dGUlhSREcvTXYwTndKdm5NMTJJRzJKU2pT?=
 =?utf-8?B?dEtFam0xaEhGcUFSNXBkZ2R4Y3UxQWJzY2dxL05BeHROZFZDcVpmYlArNTZ0?=
 =?utf-8?B?L1NrOWIxVk9Hd3lycVRDQVVxQ05oQnpvMWlud2w2b0toQU16aEgxcU93UlJK?=
 =?utf-8?B?TllhcjNBQnQ4TkxibnhJTEcxWFFoVFdTNlFEaGVndExjM3VzSGxLOXJDZ1Rh?=
 =?utf-8?B?R2Z1bkIvWkVhUTMvc0t0WXVYR0VpZ0RwL0ZTVzFmbnB4aUdka01MMXE0eGhu?=
 =?utf-8?B?aUlOdmFPY1VUTlhsQjRpdnIvOEpzMFRPRnJaTjl1a3hPcXB5MmJpdkIraFNz?=
 =?utf-8?B?RDZjMkxLQ1hFSk0rRGh3TzE1NHpodlhONTZOMkRYQ2g3OUF5WHlGQk9nPT0=?=
X-Microsoft-Antispam-Message-Info: ob77YfbybtaV7x/UnDwc9spZEQbjcPimFEVbwaJGOOExcJnzcZxpNeNc0uofBcYSnsFyr2j0aq1rwtjcJR+B/6Bl73y9254CYfb3VuAqSI1wyHgJX8rXBHCrtf+BTH/Y/iapzN/5E5ywNg6TS5Mss2gSOUP4q8RGQf40gKQGI4ZDIVibDTxxQHbeTR0FSuaMBhqokVZaxlK9trAIrVOxUlJbHiTTAZiRK9/jAzPSi1mH3bDOrWtiOSuCBnHYPbgFLSr7U81e19htEW2GGknaa5MKkTtvJczhL5iFjHrV7uNTCQofem5wAH++XkxNVtBvVyRRMuoVkZvrlcgAZCgO0yWKwLnE9mPToJCjpjDqYu7KiKYx3FlAcevKYRvwlG5xH8jO35ZwyYQanVK092be/Q==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4706;6:SEj+R05F/kJSFYdeJuZuzHYUqUtK1dO9i9fXVblzC6ODu74bCyBcmO63NPIds0ykIjmowcPe04oObKBfjtQUPLYFMBHRG9eSfynh9WmtgsqT/AssbPMF+tLQ44DPVHo5HWiSsjNk/Eg3YpLsLaTb8ZA+ZvxaWfZDzuErsu4q1fCNDRpFyacYAM1/hAToDZ6RIjBzFgkwbRQIpMRC0eIBb5+G2j74G01yROF4VimUg/L7vwEEpIwNFY3AMianWBQxiDHRO+Pq3eyMPHAyQ5OKGwu+IZiZFnRTPxyvIbQDUFD08sSkz/kqamnH/zq/QERpQ8rVj7T61fskp8Be4KuSFpStyY0GyfqvTmxwC3X66OHY4GzHbCXQ0J7b6Vp9SYVwQpd/OV6G40NnJdFIhdMMT77w+yJoU3aLAPyvfYQGzwgig1lDB3FY7dtULYVubysHYr9sdlShyCgnMQnD2GsxmQ==;5:7rP1L89b+Ni15PP7Uodso3gPrT2lQFacHF6Kj/Q1sWxFjXLQNI6AtukXRkZNxu9Idr3Lgh87970csu7T0UXl08YusdpUw/c3k3CnF3tE83uSwXa2Ub5H3YyImMhvFdDl29cyJjx64JINSm+6eda1LNIirIRAwMBUe+Y5qTRgC4I=;24:lyixo/uZWYlU36tbfUFIPb6UASwcH6eD6wDMrop2FmodsuDblZcoPGid6VP0wQbinpTQw+ndVQGFB8YyIMQ+aLeIxLjnEeTirl5EVs637ws=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4706;7:6nUIO3NGICJGXNAdixhJJ/B4eBvazHJflPxl7uTv2x8YFDHPyeuSSCIhEE6XZOm2ouR7CwJkTZV9gj25duz2NHfi6/JfldTg+3T+NXVHpKLBxUyipk6c9fTQiEd0BSkKTjLjp+klgQAV5YT6PTtRaF4g6tv6W+b+Tfts3WbcsezneKJdwOCr3CaZ5cvGAGFoDXEGWv/aEXzTvOQmVyB0aQuR3UVGo4WIuOdEGupgZb070oY5ta+4oJzFdHB+vN8e;20:wzrRnT7XT6AGvdxyk1p3F2G38P0QaQUY+ODlJhDlZXSetuonEFfeYrcNO9js8C7peJeMa4DltKubdqZND8EWeZy48ny3umIoo+PrefbecxFN0vJu/Ufl2EqEAnkZA7e10G9+GcRk0E4eqUqB8ZtEb5TWSSJ/uef2aIwuorheJcg/PeQu2Jx9F2F2Y/d55MnTJb1SkSLZJvSE5pqojBm7JHQxPv9Wv01jb1t6BoIs+u/I4+i4KagQNqB1vsEB8CCR
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:19.6280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d67e44-9345-4b41-daf9-08d5eda15a13
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4706
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implement handle_port_status function and all related to
it other functions.

It is called in interrupt context from usbssp_irq function.

handle_port_status function is responsible for handling all events
related to USB port.

To correct handle some port events driver needs to add commands to
Command Ring. These commands are processed by HW. Each command
can take some time and driver need to wait for completion.
Therefor driver can’t handle all events in interrupt context and
Some of them must be deferred and will be handled in separate thread.
This additional thread will be introduced in separate patch.

Patch also introduces gadget-port.c file that contains functions related
to USB port, such as detecting port speed and setting link state.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/Makefile      |   2 +-
 drivers/usb/usbssp/gadget-if.c   |  59 +++++
 drivers/usb/usbssp/gadget-port.c | 102 ++++++++
 drivers/usb/usbssp/gadget-ring.c | 414 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h      |  13 +
 5 files changed, 582 insertions(+), 8 deletions(-)
 create mode 100644 drivers/usb/usbssp/gadget-port.c

diff --git a/drivers/usb/usbssp/Makefile b/drivers/usb/usbssp/Makefile
index 4f5f12ab6420..f867124f286c 100644
--- a/drivers/usb/usbssp/Makefile
+++ b/drivers/usb/usbssp/Makefile
@@ -4,7 +4,7 @@ CFLAGS_gadget-trace.o := -I$(src)
 
 obj-$(CONFIG_USB_USBSSP_GADGET) += usbssp.o
 usbssp-y 			:= usbssp-plat.o gadget-ring.o \
-				   gadget.o gadget-mem.o \
+				   gadget.o gadget-mem.o gadget-port.o \
 				    gadget-dbg.o
 
 ifneq ($(CONFIG_TRACING),)
diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
index 70def978b085..6f42ad33979d 100644
--- a/drivers/usb/usbssp/gadget-if.c
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -287,3 +287,62 @@ void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data)
 			list_del(&ep_priv->endpoint.ep_list);
 	}
 }
+
+void usbssp_suspend_gadget(struct usbssp_udc *usbssp_data)
+{
+	if (usbssp_data->gadget_driver && usbssp_data->gadget_driver->suspend) {
+		spin_unlock(&usbssp_data->lock);
+		usbssp_data->gadget_driver->suspend(&usbssp_data->gadget);
+		spin_lock(&usbssp_data->lock);
+	}
+}
+
+void usbssp_resume_gadget(struct usbssp_udc *usbssp_data)
+{
+	if (usbssp_data->gadget_driver && usbssp_data->gadget_driver->resume) {
+		spin_unlock(&usbssp_data->lock);
+		usbssp_data->gadget_driver->resume(&usbssp_data->gadget);
+		spin_lock(&usbssp_data->lock);
+	}
+}
+
+static void usbssp_reset_gadget(struct usbssp_udc *usbssp_data)
+{
+	if (!usbssp_data->gadget_driver)
+		return;
+
+	if (usbssp_data->gadget.speed != USB_SPEED_UNKNOWN) {
+		spin_unlock(&usbssp_data->lock);
+		usb_gadget_udc_reset(&usbssp_data->gadget,
+				usbssp_data->gadget_driver);
+		spin_lock(&usbssp_data->lock);
+	}
+}
+void usbssp_gadget_reset_interrupt(struct usbssp_udc *usbssp_data)
+{
+	usbssp_reset_gadget(usbssp_data);
+	switch (usbssp_data->gadget.speed) {
+	case USB_SPEED_SUPER_PLUS:
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
+		usbssp_data->gadget.ep0->maxpacket = 512;
+		break;
+	case USB_SPEED_SUPER:
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
+		usbssp_data->gadget.ep0->maxpacket = 512;
+		break;
+	case USB_SPEED_HIGH:
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
+		usbssp_data->gadget.ep0->maxpacket = 64;
+		break;
+	case USB_SPEED_FULL:
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(64);
+		usbssp_data->gadget.ep0->maxpacket = 64;
+		break;
+	case USB_SPEED_LOW:
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(8);
+		usbssp_data->gadget.ep0->maxpacket = 8;
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/usb/usbssp/gadget-port.c b/drivers/usb/usbssp/gadget-port.c
new file mode 100644
index 000000000000..09ea5b574ae0
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-port.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp
+ */
+
+#include <linux/slab.h>
+#include <asm/unaligned.h>
+
+#include "gadget-trace.h"
+#include "gadget.h"
+
+unsigned int usbssp_port_speed(unsigned int port_status)
+{
+	/*Detect gadget speed*/
+	if (DEV_SUPERSPEEDPLUS(port_status))
+		return USB_SPEED_SUPER_PLUS;
+	else if (DEV_SUPERSPEED(port_status))
+		return USB_SPEED_SUPER;
+	else if (DEV_HIGHSPEED(port_status))
+		return USB_SPEED_HIGH;
+	else if (DEV_FULLSPEED(port_status))
+		return USB_SPEED_FULL;
+	else if (DEV_LOWSPEED(port_status))
+		return USB_SPEED_LOW;
+
+	/*if device is detached then speed will be USB_SPEED_UNKNOWN*/
+	return USB_SPEED_UNKNOWN;
+}
+
+/*
+ * These bits are Read Only (RO) and should be saved and written to the
+ * registers: 0, 3, 10:13, 30
+ * connect status, over-current status and port speed.
+ * connect status and port speed are also sticky - meaning they're in
+ * the AUX well and they aren't changed by a hot and warm.
+ */
+#define USBSSP_PORT_RO	(PORT_CONNECT | PORT_OC | DEV_SPEED_MASK)
+
+/*
+ * These bits are RW; writing a 0 clears the bit, writing a 1 sets the bit:
+ * bits 5:8, 9, 14:15, 25:27
+ * link state, port power, port indicator state, "wake on" enable state
+ */
+#define USBSSP_PORT_RWS	(PORT_PLS_MASK | PORT_POWER | PORT_WKCONN_E | \
+			PORT_WKDISC_E | PORT_WKOC_E)
+
+/*
+ * Given a port state, this function returns a value that would result in the
+ * port being in the same state, if the value was written to the port status
+ * control register.
+ * Save Read Only (RO) bits and save read/write bits where
+ * writing a 0 clears the bit and writing a 1 sets the bit (RWS).
+ * For all other types (RW1S, RW1CS, RW, and RZ), writing a '0' has no effect.
+ */
+u32 usbssp_port_state_to_neutral(u32 state)
+{
+	/* Save read-only status and port state */
+	return (state & USBSSP_PORT_RO) | (state & USBSSP_PORT_RWS);
+}
+
+__le32 __iomem *usbssp_get_port_io_addr(struct usbssp_udc *usbssp_data)
+{
+	if (usbssp_data->port_major_revision == 0x03)
+		return usbssp_data->usb3_ports;
+	else
+		return usbssp_data->usb2_ports;
+}
+
+void usbssp_set_link_state(struct usbssp_udc *usbssp_data,
+			   __le32 __iomem *port_regs,
+			   u32 link_state)
+{
+	u32 temp;
+
+	temp = readl(port_regs);
+	temp = usbssp_port_state_to_neutral(temp);
+	temp &= ~PORT_PLS_MASK;
+	temp |= PORT_LINK_STROBE | link_state;
+	writel(temp, port_regs);
+}
+
+/* Test and clear port RWC bit */
+void usbssp_test_and_clear_bit(struct usbssp_udc *usbssp_data,
+			       __le32 __iomem *port_regs,
+			       u32 port_bit)
+{
+	u32 temp;
+
+	temp = readl(port_regs);
+	if (temp & port_bit) {
+		temp = usbssp_port_state_to_neutral(temp);
+		temp |= port_bit;
+		writel(temp, port_regs);
+	}
+}
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index f6a6269e071d..6679d8ec7152 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -102,6 +102,11 @@ static bool link_trb_toggles_cycle(union usbssp_trb *trb)
 	return le32_to_cpu(trb->link.control) & LINK_TOGGLE;
 }
 
+static void inc_td_cnt(struct usbssp_request *priv_req)
+{
+	priv_req->num_tds_done++;
+}
+
 /*
  * See Cycle bit rules. SW is the consumer for the event ring only.
  * Don't make a ring full of link TRBs. That would be dumb and this would loop.
@@ -220,18 +225,82 @@ static bool usbssp_mod_cmd_timer(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
-irqreturn_t usbssp_irq(int irq, void *priv)
+static void usbssp_kill_ring_requests(struct usbssp_udc *usbssp_data,
+				      struct usbssp_ring *ring)
 {
-	struct usbssp_udc *usbssp_data = (struct usbssp_udc *)priv;
-	irqreturn_t ret = IRQ_NONE;
-	unsigned long flags;
+	struct usbssp_td *cur_td;
+	struct usbssp_td *tmp;
 
-	spin_lock_irqsave(&usbssp_data->lock, flags);
+	list_for_each_entry_safe(cur_td, tmp, &ring->td_list, td_list) {
+		list_del_init(&cur_td->td_list);
+		inc_td_cnt(cur_td->priv_request);
+	}
+}
 
-	spin_unlock_irqrestore(&usbssp_data->lock, flags);
-	return ret;
+void usbssp_kill_endpoint_request(struct usbssp_udc *usbssp_data,
+				  int ep_index)
+{
+	struct usbssp_ep *ep;
+	struct usbssp_ring *ring;
+
+	ep = &usbssp_data->devs.eps[ep_index];
+	if ((ep->ep_state & EP_HAS_STREAMS) ||
+	    (ep->ep_state & EP_GETTING_NO_STREAMS)) {
+		int stream_id;
+
+		for (stream_id = 0; stream_id < ep->stream_info->num_streams;
+		     stream_id++) {
+
+			ring = ep->stream_info->stream_rings[stream_id];
+			if (!ring)
+				continue;
+
+			usbssp_dbg_trace(usbssp_data,
+				trace_usbssp_dbg_cancel_request,
+				"Killing Requests for slot ID %u,"
+				"ep index %u, stream %u",
+				usbssp_data->slot_id, ep_index, stream_id + 1);
+			usbssp_kill_ring_requests(usbssp_data, ring);
+		}
+	} else {
+		ring = ep->ring;
+		if (!ring)
+			return;
+
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_cancel_request,
+				"Killing Requests for slot ID %u, ep index %u",
+				usbssp_data->slot_id, ep_index);
+		usbssp_kill_ring_requests(usbssp_data, ring);
+	}
 }
 
+/*
+ * USBSSP controller died, register read returns 0xffffffff
+ * Complete pending commands, mark them ABORTED.
+ * USB requests need to be given back as gadget core might be waiting with
+ * device lock held for the Requests to finish during device disconnect,
+ * blocking device remove.
+ *
+ */
+void usbssp_udc_died(struct usbssp_udc *usbssp_data)
+{
+	int i;
+
+	if (usbssp_data->usbssp_state & USBSSP_STATE_DYING)
+		return;
+
+	dev_err(usbssp_data->dev,
+			"USBSSP controller not responding, assume dead\n");
+	usbssp_data->usbssp_state |= USBSSP_STATE_DYING;
+
+	usbssp_cleanup_command_queue(usbssp_data);
+
+	/* return any pending requests, remove may be waiting for them */
+	for (i = 0; i < 31; i++)
+		usbssp_kill_endpoint_request(usbssp_data, i);
+}
+
+
 void usbssp_handle_command_timeout(struct work_struct *work)
 {
 	/*TODO: implements function*/
@@ -258,6 +327,166 @@ void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data)
 		usbssp_complete_del_and_free_cmd(cur_cmd, COMP_COMMAND_ABORTED);
 }
 
+static void handle_port_status(struct usbssp_udc *usbssp_data,
+			       union usbssp_trb *event)
+{
+	u32 port_id;
+	u32 portsc, cmd_regs;
+	int max_ports;
+	u8 major_revision;
+	__le32 __iomem *port_regs;
+
+	/* Port status change events always have a successful completion code */
+	if (GET_COMP_CODE(le32_to_cpu(event->generic.field[2])) != COMP_SUCCESS)
+		dev_err(usbssp_data->dev,
+			"WARN: USBSSP returned failed port status event\n");
+
+
+	port_id = GET_PORT_ID(le32_to_cpu(event->generic.field[0]));
+	dev_dbg(usbssp_data->dev,
+		"Port Status Change Event for port %d\n", port_id);
+
+	usbssp_data->devs.port_num = port_id;
+	max_ports = HCS_MAX_PORTS(usbssp_data->hcs_params1);
+
+	if ((port_id <= 0) || (port_id > max_ports)) {
+		dev_err(usbssp_data->dev, "Invalid port id %d\n", port_id);
+		inc_deq(usbssp_data, usbssp_data->event_ring);
+		return;
+	}
+
+	if (!usbssp_data->port_major_revision) {
+		/*
+		 * Figure out to which USB port device is attached:
+		 * is it a USB 3.0 port or a USB 2.0/1.1 port?
+		 */
+		major_revision = usbssp_data->port_array[port_id - 1];
+
+		if (major_revision == 0) {
+			dev_warn(usbssp_data->dev, "Event for port %u not in "
+					"Extended Capabilities, ignoring.\n",
+					port_id);
+			goto cleanup;
+		}
+
+		usbssp_data->port_major_revision = major_revision;
+	}
+
+	port_regs = usbssp_get_port_io_addr(usbssp_data);
+
+	portsc = readl(port_regs);
+	trace_usbssp_handle_port_status(usbssp_data->devs.port_num, portsc);
+	usbssp_data->gadget.speed = usbssp_port_speed(portsc);
+	dev_dbg(usbssp_data->dev, "PORTSC info: %s\n",
+			usbssp_decode_portsc(portsc));
+
+	if ((portsc & PORT_PLC) && (portsc & PORT_PLS_MASK) == XDEV_RESUME) {
+		dev_dbg(usbssp_data->dev, "port resume event for port %d\n",
+				port_id);
+		cmd_regs = readl(&usbssp_data->op_regs->command);
+		if (!(cmd_regs & CMD_RUN)) {
+			dev_warn(usbssp_data->dev, "DC is not running.\n");
+			goto cleanup;
+		}
+		if (DEV_SUPERSPEED_ANY(portsc)) {
+			dev_dbg(usbssp_data->dev, "remote wake SS port %d\n",
+					port_id);
+			usbssp_test_and_clear_bit(usbssp_data, port_regs,
+					PORT_PLC);
+			usbssp_set_link_state(usbssp_data, port_regs, XDEV_U0);
+			usbssp_resume_gadget(usbssp_data);
+			goto cleanup;
+		}
+	}
+
+	if ((portsc & PORT_PLC) && (portsc & PORT_PLS_MASK) == XDEV_U0 &&
+	     DEV_SUPERSPEED_ANY(portsc)) {
+		dev_dbg(usbssp_data->dev, "resume SS port %d\n", port_id);
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_PLC);
+	}
+
+	if ((portsc & PORT_PLC) && (portsc & PORT_PLS_MASK) == XDEV_U1 &&
+	     DEV_SUPERSPEED_ANY(portsc)) {
+		dev_dbg(usbssp_data->dev, "suspend U1 SS port %d\n", port_id);
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_PLC);
+		usbssp_suspend_gadget(usbssp_data);
+	}
+
+	if ((portsc & PORT_PLC) && ((portsc & PORT_PLS_MASK) == XDEV_U2 ||
+	    (portsc & PORT_PLS_MASK) == XDEV_U3)) {
+		dev_dbg(usbssp_data->dev, "resume SS port %d finished\n",
+				port_id);
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_PLC);
+		usbssp_suspend_gadget(usbssp_data);
+	}
+
+	/*Attach device */
+	if ((portsc & PORT_CSC) && (portsc & PORT_CONNECT)) {
+		dev_dbg(usbssp_data->dev, "Port status change: Device Attached\n");
+		usbssp_data->defered_event |= EVENT_DEV_CONNECTED;
+		queue_work(usbssp_data->bottom_irq_wq,
+				&usbssp_data->bottom_irq);
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_CSC);
+	}
+
+	/*Detach device*/
+	if ((portsc & PORT_CSC) && !(portsc & PORT_CONNECT)) {
+		dev_dbg(usbssp_data->dev,
+				"Port status change: Device Deattached\n");
+		usbssp_data->defered_event |= EVENT_DEV_DISCONECTED;
+		queue_work(usbssp_data->bottom_irq_wq,
+				&usbssp_data->bottom_irq);
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_CSC);
+	}
+
+	/*Port Reset Change - port is in reset state */
+	if ((portsc & PORT_RC) && (portsc & PORT_RESET)) {
+		dev_dbg(usbssp_data->dev,
+			"Port status change: Port reset signaling detected\n");
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_RC);
+	}
+
+	/*Port Reset Change - port is not in reset state */
+	if ((portsc & PORT_RC) && !(portsc & PORT_RESET)) {
+		dev_dbg(usbssp_data->dev,
+			"Port status change: Port reset completion detected\n");
+		usbssp_gadget_reset_interrupt(usbssp_data);
+		usbssp_data->defered_event |= EVENT_USB_RESET;
+		queue_work(usbssp_data->bottom_irq_wq,
+				&usbssp_data->bottom_irq);
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_RC);
+	}
+
+	/*Port Warm Reset Change*/
+	if (portsc & PORT_WRC) {
+		dev_dbg(usbssp_data->dev,
+			"Port status change: Port Warm Reset detected\n");
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_WRC);
+	}
+
+	/*Port Over-Curretn Change*/
+	if (portsc & PORT_OCC) {
+		dev_dbg(usbssp_data->dev,
+			"Port status change: Port Over Current detected\n");
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_OCC);
+	}
+
+	/*Port Configure Error Change*/
+	if (portsc & PORT_CEC) {
+		dev_dbg(usbssp_data->dev,
+			"Port status change: Port Configure Error detected\n");
+		usbssp_test_and_clear_bit(usbssp_data, port_regs, PORT_CEC);
+	}
+
+	if (usbssp_data->port_major_revision == 0x02)
+		usbssp_test_and_clear_bit(usbssp_data, port_regs,
+					PORT_PLC);
+
+cleanup:
+	/* Update event ring dequeue pointer before dropping the lock */
+	inc_deq(usbssp_data, usbssp_data->event_ring);
+}
+
 /*
  * This TD is defined by the TRBs starting at start_trb in start_seg and ending
  * at end_trb, which may be in another segment. If the suspect DMA address is a
@@ -334,6 +563,177 @@ struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
 	return NULL;
 }
 
+/*
+ * This function handles all events on the event ring.
+ * Function can defers handling of some events to kernel thread.
+ * Returns >0 for "possibly more events to process" (caller should call again),
+ * otherwise 0 if done. In future, <0 returns should indicate error code.
+ */
+int usbssp_handle_event(struct usbssp_udc *usbssp_data)
+{
+	union usbssp_trb *event;
+	int update_ptrs = 1;
+	__le32 cycle_bit;
+
+	if (!usbssp_data->event_ring || !usbssp_data->event_ring->dequeue) {
+		dev_err(usbssp_data->dev, "ERROR event ring not ready\n");
+		return -ENOMEM;
+	}
+
+	event = usbssp_data->event_ring->dequeue;
+
+	cycle_bit = (le32_to_cpu(event->event_cmd.flags) & TRB_CYCLE);
+	/* Does the USBSSP or Driver own the TRB? */
+	if (cycle_bit != usbssp_data->event_ring->cycle_state)
+		return 0;
+
+	trace_usbssp_handle_event(usbssp_data->event_ring, &event->generic);
+
+	/*
+	 * Barrier between reading the TRB_CYCLE (valid) flag above and any
+	 * speculative reads of the event's flags/data below.
+	 */
+	rmb();
+
+	switch ((le32_to_cpu(event->event_cmd.flags) & TRB_TYPE_BITMASK)) {
+	case TRB_TYPE(TRB_PORT_STATUS):
+		handle_port_status(usbssp_data, event);
+		update_ptrs = 0;
+		break;
+	default:
+		dev_warn(usbssp_data->dev, "ERROR unknown event type %ld\n",
+			TRB_FIELD_TO_TYPE(
+			le32_to_cpu(event->event_cmd.flags)));
+	}
+
+
+	/*
+	 * Any of the above functions may drop and re-acquire the lock, so check
+	 * to make sure a watchdog timer didn't mark the device as
+	 * non-responsive.
+	 */
+	if (usbssp_data->usbssp_state & USBSSP_STATE_DYING) {
+		dev_dbg(usbssp_data->dev, "USBSSP device dying, returning from "
+			"event handle.\n");
+		return 0;
+	}
+
+	if (update_ptrs) {
+		/* Update SW event ring dequeue pointer */
+		inc_deq(usbssp_data, usbssp_data->event_ring);
+	}
+
+	/*
+	 * Are there more items on the event ring? Caller will call us again to
+	 * check.
+	 */
+	return 1;
+}
+
+irqreturn_t usbssp_irq(int irq, void *priv)
+{
+	struct usbssp_udc *usbssp_data = (struct usbssp_udc *)priv;
+	union usbssp_trb *event_ring_deq;
+	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags;
+	dma_addr_t deq;
+	u64 temp_64;
+	u32 status;
+
+	spin_lock_irqsave(&usbssp_data->lock, flags);
+
+	/*
+	 * Check if the USBSSP controller generated the interrupt,
+	 * or the irq is shared
+	 */
+	status = readl(&usbssp_data->op_regs->status);
+	if (status == ~(u32)0) {
+		usbssp_udc_died(usbssp_data);
+		ret = IRQ_HANDLED;
+		goto out;
+	}
+
+	if (!(status & STS_EINT))
+		goto out;
+
+	if (status & STS_FATAL) {
+		dev_warn(usbssp_data->dev, "WARNING: Device Controller Error\n");
+		usbssp_halt(usbssp_data);
+		ret = IRQ_HANDLED;
+		goto out;
+	}
+
+	/*
+	 * Clear the op reg interrupt status first,
+	 * so we can receive interrupts from other MSI-X interrupters.
+	 * Write 1 to clear the interrupt status.
+	 */
+	status |= STS_EINT;
+	writel(status, &usbssp_data->op_regs->status);
+
+	if (usbssp_data->msi_enabled) {
+		u32 irq_pending;
+
+		irq_pending = readl(&usbssp_data->ir_set->irq_pending);
+		irq_pending |= IMAN_IP;
+		writel(irq_pending, &usbssp_data->ir_set->irq_pending);
+	}
+
+	if (usbssp_data->usbssp_state & USBSSP_STATE_DYING ||
+			usbssp_data->usbssp_state & USBSSP_STATE_HALTED) {
+		dev_dbg(usbssp_data->dev,
+				"USBSSP controller dying, ignoring interrupt. "
+				"Shouldn't IRQs be disabled?\n");
+		/*
+		 * Clear the event handler busy flag (RW1C);
+		 * the event ring should be empty.
+		 */
+		temp_64 = usbssp_read_64(usbssp_data,
+				&usbssp_data->ir_set->erst_dequeue);
+		usbssp_write_64(usbssp_data, temp_64 | ERST_EHB,
+				&usbssp_data->ir_set->erst_dequeue);
+		ret = IRQ_HANDLED;
+		goto out;
+	}
+
+	event_ring_deq = usbssp_data->event_ring->dequeue;
+
+	while ((ret = usbssp_handle_event(usbssp_data)) == 1) {
+	}
+
+	temp_64 = usbssp_read_64(usbssp_data,
+			&usbssp_data->ir_set->erst_dequeue);
+	/* If necessary, update the HW's version of the event ring deq ptr. */
+	if (event_ring_deq != usbssp_data->event_ring->dequeue) {
+
+		deq = usbssp_trb_virt_to_dma(usbssp_data->event_ring->deq_seg,
+				usbssp_data->event_ring->dequeue);
+
+		if (deq == 0)
+			dev_warn(usbssp_data->dev,
+					"WARN something wrong with SW event "
+					"ring dequeue ptr.\n");
+		/* Update USBSSP event ring dequeue pointer */
+		temp_64 &= ERST_PTR_MASK;
+		temp_64 |= ((u64) deq & (u64) ~ERST_PTR_MASK);
+	}
+
+	/* Clear the event handler busy flag (RW1C); event ring is empty. */
+	temp_64 |= ERST_EHB;
+	usbssp_write_64(usbssp_data, temp_64,
+			&usbssp_data->ir_set->erst_dequeue);
+	ret = IRQ_HANDLED;
+
+out:
+	spin_unlock_irqrestore(&usbssp_data->lock, flags);
+	return ret;
+}
+
+irqreturn_t usbssp_msi_irq(int irq, void *usbssp_data)
+{
+	return usbssp_irq(irq, usbssp_data);
+}
+
 /****		Endpoint Ring Operations	****/
 
 /*
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 0970c7ddcd38..33eccffc885d 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1725,11 +1725,22 @@ struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
 void usbssp_handle_command_timeout(struct work_struct *work);
 
 void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data);
+/* USBSSP port code */
+void usbssp_set_link_state(struct usbssp_udc *usbssp_data,
+			__le32 __iomem *port_regs, u32 link_state);
+
+void usbssp_test_and_clear_bit(struct usbssp_udc *usbssp_data,
+			__le32 __iomem *port_regs, u32 port_bit);
+
 /* USBSSP gadget interface*/
+void usbssp_suspend_gadget(struct usbssp_udc *usbssp_data);
+void usbssp_resume_gadget(struct usbssp_udc *usbssp_data);
 int usbssp_gadget_init(struct usbssp_udc *usbssp_data);
 int usbssp_gadget_exit(struct usbssp_udc *usbssp_data);
 void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data);
 int usbssp_gadget_init_endpoint(struct usbssp_udc *usbssp_data);
+unsigned int usbssp_port_speed(unsigned int port_status);
+void usbssp_gadget_reset_interrupt(struct usbssp_udc *usbssp_data);
 
 static inline char *usbssp_slot_state_string(u32 state)
 {
@@ -2203,4 +2214,6 @@ struct usbssp_udc;
 
 #define to_usbssp_request(r) (container_of(r, struct usbssp_request, request))
 
+__le32 __iomem *usbssp_get_port_io_addr(struct usbssp_udc *usbssp_data);
+
 #endif /* __LINUX_USBSSP_GADGET_H */
-- 
2.17.1

