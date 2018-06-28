Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1C7C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80F526FC8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MOt2DXrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80F526FC8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeF1Gkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:40:41 -0400
Received: from mail-bl2nam02on0069.outbound.protection.outlook.com ([104.47.38.69]:43335
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751354AbeF1Gkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bOcOEvNZY6N+Z+d3STtDv5dYrRvLw4eKkV9LEBDik0=;
 b=MOt2DXrDHwGxWu5OKGcvLD+stV0do5TeXCEZyMiMvwhWd/tprAYO16Vuc91diTF8wtx2Zkh57IxpkWAdBtf9jHUWlJsMeitt3+uiYF18bOLLDNOWdzQFBJY/pg4cVAWHnvnZn/+EmFaaoKlElKHBDiIGQyPvfxXJYm+3ix6e1NM=
Received: from CY4PR02CA0042.namprd02.prod.outlook.com (2603:10b6:903:117::28)
 by CY4PR02MB2645.namprd02.prod.outlook.com (2603:10b6:903:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Thu, 28 Jun
 2018 06:40:33 +0000
Received: from CY1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by CY4PR02CA0042.outlook.office365.com
 (2603:10b6:903:117::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.23 via Frontend
 Transport; Thu, 28 Jun 2018 06:40:33 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT036.mail.protection.outlook.com (10.152.75.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 06:40:33 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fYQbY-0003Cp-Nf; Wed, 27 Jun 2018 23:40:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fYQbT-00044e-KA; Wed, 27 Jun 2018 23:40:27 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5S6eLUo016247;
        Wed, 27 Jun 2018 23:40:22 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fYQbN-0003zP-JG; Wed, 27 Jun 2018 23:40:21 -0700
Subject: Re: [RFC PATCH 4/5] arm: dts: zynq: rename board zed to zedboard
To:     Luis Araneda <luaraneda@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180628054205.17737-1-luaraneda@gmail.com>
 <20180628054205.17737-5-luaraneda@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <9d00dae5-835f-43b4-0a78-2aa43bbcff54@xilinx.com>
Date:   Thu, 28 Jun 2018 08:40:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628054205.17737-5-luaraneda@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39850400004)(2980300002)(438002)(199004)(189003)(11346002)(6246003)(6666003)(4326008)(230700001)(106002)(50466002)(478600001)(316002)(2906002)(54906003)(305945005)(58126008)(110136005)(81166006)(9786002)(64126003)(126002)(476003)(486006)(2616005)(8676002)(39060400002)(81156014)(356003)(63266004)(36386004)(426003)(336012)(31686004)(44832011)(446003)(31696002)(106466001)(186003)(26005)(77096007)(65826007)(8936002)(65806001)(76176011)(2486003)(36756003)(23676004)(53546011)(65956001)(47776003)(5660300001)(229853002)(107986001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2645;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT036;1:UmYq5YWPt+IHrE+BohsWFJeaFEgBJZZCPsCug/t/xFhwVUzAfEHW4auTnFPCszyxejTZZXBND+Ccc66Wjiz/6kD0sDyEapnv/YcjBdi2+rTalapQA47sjcKYV5379nZi
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6159779-e263-469f-8d05-08d5dcc20c94
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR02MB2645;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2645;3:dpXI/Cxo1fzheL8r1PcQPPYfdiHo2wCt8vwVwKNpmsSQRgAtDw7djei3rfcpCR+bVbmccAzaUT9yKmZW0QDmkX2R6+54kIE3Xncl3EtxBQTNpCfILTSLSuHDZwNXgsUVxkjrZhk/SWqkMI55ECxh4vgfwI/l7wFB+gizqXP0mueYmTs2M+Pohf9L2Bu1nEcNA6qZHgR87dodYDt3nvDFOL7aAqLybqFSE426l83YdN8KvDVEqqgyLxO5nJPMgaQ6FcwKtYn2HISD9d71ZOmiJVXYXBFypLiEADviJFTjniHV1K/kSqunwprJIcwd5Hv96u/UGXspArsE3eYXYMwdPbtshJhu6+CEuNfKin5nzi4=;25:EgbgzuFjkyfdGoS+DR/F5+U8JITrjCwyO9gor5Pgruq0a5mwqc0RRBOdquqCioQ01xzkhrj2qwRXNUctM7Flu+OdaNmS2UtJEQeA0woT+ikh6q6zdmmwxFMN1+7oLMY0lewBYWLgL/vfldfYjXW7qlBejnu+5kAKCyA+oHuqN7d/5U37tXKMR9yB9MjTSfnLMXcp1f8kohhlSQKwnqkqCj9+XdncI0e/RLgX080f4PexzoMI2SxpWvpKyEcaxw13kLg/SBtwWXjlThiK7KKyZ3thZEKoumSuIgDMpkKH1gDbbikYnlkgxuw5UXKCHGxZfRSLjNHZ8/9ek0ZvyUdH5w==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2645:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2645;31:9AzK78wZVeFul0BYBDjE0MeivqT3+bdUSMsZCq3EJhcoi7JVBiwz0QhNqZwn7e3R+pImioBQ0WnlNee+Ivw9SQQtDOpLaP1qH5bprocyDD4kY9xLT0ULlr1tEsB7LcQ/vcdqrgYzzC8Dp/etlNzXXNrsixxtbhckfSYtjLtbluTReMBdFinQVa+SO2oc2Q2Qnh5kmlrDYLwp3PHrCSAZnthfVS4IpAgOYQlZ3xfV0rk=;20:UjeEWeNHZTaSCRqLbgEUlM7WDFXVMuAFZVs1NeBhLTSL4Qeu4OZznuci/ibOTyoSv1kCDaem8gyGpurnOJ/QM0BIT0fDaJz+uNRpKrtQLog+eyTEqBG4wmqeLFKPjXwpE/eBGs/8IkmbYS6csdZKzyguhhYXTuwKYeTyck0sZzGe59Kjm/9jx2mikQaeQHgV3KF5P83ExSBIHESbM0Yd8oIoNMe5p01TY26wyc15Xy9KVCkbM9+v0jjPQwQcx1HNdBdXsg4vPIiXrRXfoFh4H+XZnvVXUXDGu1e4FV78qLK8BpkQzYCXw1siDxXf3UyWe0eV/eXe6hBX8xZ3WyvdCLDqywb5f1KkGzZ8HO+Urp/i7clWpNo2Cm51IQEN8ZDcjC049zjH2Z/rxiJSmXeWb+oy/rCP7q9tBmOnre/yayIoSi5KWaIC6qoyhY4q8fOe2JSLMuEs57a3mLz/W1trxeVHECIL4OfQo0iaO0p8K+ljKxtdt6Yi4RIwIx/S5bDD
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB2645D64540CD3559FFB80991C64F0@CY4PR02MB2645.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR02MB2645;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2645;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2645;4:9kg+1LrH4iXVd7nkmeZVfyGereyBqoiJ/KIuvFblh5qXsfanEYSShANC7FwVlh9a/hC1M5pvBSAPqXjUm7yi+YVJVpZUG3nqa5vP8ASEOSuRP8WqoCUM+rUdzrA7sFiiibsKHxhyZTeLC5mzsTGlzQUMg29WTreRyo3+1TX66y8YGP/3twxV3B0/ZThobopDj7An2pNRWZN4De36pGxQMteiFRGIAetRlnO9uPcU1ryb0E1c62Zums80ln/EHBWGwgDLWFyzDVCfsDqlJp5BYnKBe6wNxv1XJ4ex2rnYEN9yFEptDJIyo+oUwHadVJLo
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjAyTUIyNjQ1OzIzOlg5TXJKNEI3ZW9DZWlnRGl0QWRpNDFUSHRP?=
 =?utf-8?B?azV3akhMZmwvcHF6NDFnMUd2VEsrdk1HcXBHVUREWWxNOUk5cGxaLy9hckxv?=
 =?utf-8?B?WlU0REU5Zm5QL1hqTVh1ODJraHVvbk43WmtrbXdBQmlkSWs4ZlcwMkxNQzhO?=
 =?utf-8?B?UE1vc0QwVHk2cGJUZWhCZzYwOThMUXBPNGhnRk8xcTlLanlYVGJMVUFDd0ZX?=
 =?utf-8?B?ZmNDTC84NWh6cGpWazM0RUdrb0JhVVRUNlBOeWU4SUVuQk1uV1VqTWxRVEJO?=
 =?utf-8?B?UUY5a3JhZFFvc3B6NzE1UzM3Yno1MHpQa0VrM01uZkloMWlRS3RVdHRMN1lE?=
 =?utf-8?B?N1FFc25yK2FiKzNna2k4TVM3OTY4TnNyUmJIQ0NlMXByOFlwT2lTSmVaQnhy?=
 =?utf-8?B?WjVjYTdoVGRuQXhqMURhWFNkM1g2UEh6dzR3TmJ4a1VWUE9PU01INEpjNHQ1?=
 =?utf-8?B?TU84VzIxMGpyOXB5OFUxL0JCY0UxcllxbTBCT3krL08zc1RlVXRSN1d6RUNN?=
 =?utf-8?B?VHR1aDRJRC9uWEM4eURrcU9YellDaXRUQmxHQkVUYWNKQ3VBMTQvWXljZHVV?=
 =?utf-8?B?N2s3Z0FxWGszY2FqY01rdC9ZVTlrczh0S2JhY3U1cWMvSDRSSzVxckRCdWh3?=
 =?utf-8?B?QXJrc3ZURC9RZTdBZFNDbnlTUnl6K1gyTE5xbHJ5NTB4UGh2M09wZ2JQMVVn?=
 =?utf-8?B?VXVoUkx2L0VldDNVRyt5bkJlV0ZiUlh3YjlXVE14dGxpa0NoaHQxQjFXWHo2?=
 =?utf-8?B?eEJkT1dsK0J0Q1puR1BBb1EwOXcvREV3VFFoN20wT2Q4SWpaWHQwQlVMRWZ6?=
 =?utf-8?B?aEdVTGdyT21HSXNoeW50WlJ5ZjZOalA3TWdGZGNBSE9BaWc3WHM0a3JURmc3?=
 =?utf-8?B?K3RUbjhYZ2xtZDRsN0x2a25Gc2lOR0RSMjI5YXFLVTdQSTk0S01ST25nOGtS?=
 =?utf-8?B?RXR6Vi9IMUFZekcrQmFSNzBxSGVoSDcyUDBhQ1hCTmgzWFVXSnNReGxXbStm?=
 =?utf-8?B?VU4wZHgvZVJrVi81RGM2dm1UbTk2b3ZnMEtXQmxoMy9hb1ZtVDkzejFHRnFG?=
 =?utf-8?B?bFJ1WHdsdjNBZ2RlZjcrRkFxdXZDZ1B6RHVYTG5URHZVN3lxNS9oaXY3YSti?=
 =?utf-8?B?UGllVXZHcFdZeWw0TEsxSzdhK25kUFIrZlFLdzRGTEU5ZGRseGpEUGZqM242?=
 =?utf-8?B?MktkWjlhSm95ZnV5ZTlGWElEcUcwQUpHaWswTGJUaWlVaFF5QzY4eEdlWFBM?=
 =?utf-8?B?eGFvZVRGd2Fqc2xkTHF0QWhlUjU1T2pSblprZlovbVphUXJxTUhZR21BeEZz?=
 =?utf-8?B?RmVDdnY0QmVhVzgvOElBYXZuN0JUby9WZTlTWWFqbnlGaHhwRGoyeGh3c1g5?=
 =?utf-8?B?TXZwMDdCZ0kzWmpXQjhXb0UyMjMxbnZURFgxdE9KSkMybUx3T0VGSkY2am1P?=
 =?utf-8?B?aC9GcnVTUnI3Q3dJRUUrbDcrZHZkLzBUb0I1dFd1VXQyZlhjZWxwam9PQXlT?=
 =?utf-8?B?MWt2TmxVbjZsUmZJcU9aYjk5NGJKblkvVzNoemlQcExWSysxaTB3T2tkOVdh?=
 =?utf-8?B?NDJlWDNEVzlzNkRKaW5zNlAyMkNVMS8yMGFPWTJIUWRkOWdxb2Y2NlZiUE1w?=
 =?utf-8?B?MW1Peml0OEVNNEV1MndTN0U4QWdwM0k3OURqVVNJRWlSN3ZMM1BaNW95RldU?=
 =?utf-8?B?QnlhUXVtTFRocnpZeWxFTVdxdDlqajl0YVlMOWNEVUFXYzIyOWt1V2wwMjJa?=
 =?utf-8?B?c2hGekJqOXBxUzJRV1pZbTBteHZ5Y0o2Mm1waE92dFVNQjZmSEUxQmNoRU9R?=
 =?utf-8?Q?o0XcxiKP4mOTR?=
X-Microsoft-Antispam-Message-Info: 6ZspXoPC+QinWYwjDmGcb3JS0R135ZV3JoG2s/+iapd5VbjHwdc6w0d9CAUiO28xoIhW+G66V9asFz+0VW5t5phg4PpNAX9c3gLB16waInLemm8SEbdOcv9Bz+Mbx2HznbLgnEw9Rf89RxIyKEq4ksuPRrQzpcBrIh/yoSjYcaPzzqC0R1XlWmC4MIp+uuraFGsy9XmnxMivAdxQJHJ5wUe919vnh8aOA4fqCda924oSEPzmkERYsZMDoZMgPwAsLpb3x+XHmrLswnNlzGxQS1+fHRpL94hSPNgyh/MFlThFJEaCCafe1/z2oDss4woZVkuqlYab6sTnvpOSPyA5Mx+ZbAVR6KyQPyAcQmk0qOE=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2645;6:jeE5FUoxyXEZkmfpO6x1rQteOOtGJmtoUOMTzY0vA+4i+iCTbYmnAu57Gol9mV+PMSFHAjb0ggMbco9w897ATBRlg2KFuXcK6RLo33NN8tjGxHVArI/p9/VlmnEnSXFxAbodhB1MANNimuxD8EyiiJ4m1FR46jaAyBKxOXBsHqjYWWF+twjx6Yngnuy5HQhD4bKY3584gfO5JWBfA//XQehhSL9u1iuhtCS/6ANQb2RIEYFDmwc77m7dfwQjh1w2LMSUWjE/X1iN3nFK06DGrhHwZEQ+q98Gh4E42+DXl8RtNaCe6G83KXzkZtIDbzzdXrvbSA2/Ztj4pwQb5W3sZTQys3976cvVDYgE+BtmzgK5i4vfn/JfkkDrgJh6YL5DS2H+RxNN1FGsAiaGf/xJ6M1a0/HxVQo3XOtpr+EoDKZ7/4Y64fZTjNta7L8I33BMNLjjWLsrUryKX/wIRg22sA==;5:fb9s9hJeKbz6aybgkMfeM7IAgmPRgHeDOD1XxFxPZDDFcctl1bZjFB9okTbnFRfXVtDT9ufBkk6CSmFu2bz3C09gIAj9upf0KJVvKz5aqIqlnUKG6JPTriTEuvOr3j2lyoXwoRhjnReu/ouL0jVtTpUJoFrbzoJybgeN3SKTHaI=;24:alO1f+pzpSCoD+OfcIUl3EXVdjJDsH4wni29lt5W6t1sQrs3lYFSZf7jH5TwqjOyKVunqb1bLmVJS1xtWSWPpusF6b8jfKpOWEMol/lR1Ko=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2645;7:53nB5bYfNMbdzBluD+V9CA/KX+0pCwxW8zj7Oqi8isJTLL354NHq7fgr7tohBO6lbECFVGjdAgvDCv+I0YPOOwCSB5iupCxImBI0T93EonI9r5KtAWYUBatqzLFSgxVs6q+k86y8LRNoBrhg8FMtpVgUv4LHGDeu7thYozTCdBDSeLWoLvRX8ilMDaFiN2KjmVYhcnDa2c2BU/xuc++IYFr/yqbLgqwytGf22N8Z0JU1hzagu3yg1kpyMdjJ72I2
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 06:40:33.1871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6159779-e263-469f-8d05-08d5dcc20c94
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2645
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.6.2018 07:42, Luis Araneda wrote:
> The real name of the board is ZedBoard, from Avnet
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/xilinx.txt      | 2 +-
>  arch/arm/boot/dts/Makefile                            | 2 +-
>  arch/arm/boot/dts/{zynq-zed.dts => zynq-zedboard.dts} | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>  rename arch/arm/boot/dts/{zynq-zed.dts => zynq-zedboard.dts} (93%)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
> index f1e911058..d10adc4d0 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
> @@ -30,7 +30,7 @@ Additional compatible strings:
>    "xlnx,zynq-zc770-xm013"
>  
>  - Avnet ZedBoard board
> -  "avnet,zynq-zed"
> +  "avnet,zynq-zedboard"
>  
>  - Digilent Zybo board
>    "digilent,zynq-zybo"
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 37a3de760..e4c39e26f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1108,7 +1108,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
>  	zynq-zc770-xm011.dtb \
>  	zynq-zc770-xm012.dtb \
>  	zynq-zc770-xm013.dtb \
> -	zynq-zed.dtb \
> +	zynq-zedboard.dtb \
>  	zynq-zybo.dtb \
>  	zynq-zybo-z7.dtb
>  dtb-$(CONFIG_MACH_ARMADA_370) += \
> diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zedboard.dts
> similarity index 93%
> rename from arch/arm/boot/dts/zynq-zed.dts
> rename to arch/arm/boot/dts/zynq-zedboard.dts
> index bf3e26dbf..540581c56 100644
> --- a/arch/arm/boot/dts/zynq-zed.dts
> +++ b/arch/arm/boot/dts/zynq-zedboard.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "Avnet ZedBoard board";
> -	compatible = "avnet,zynq-zed", "xlnx,zynq-7000";
> +	compatible = "avnet,zynq-zedboard", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> 

It will just cause confusion and I can't see any benefit to rename this
file. If you want to state different compatible string with full board
name I am fine with that but that's it.

Thanks,
Michal
