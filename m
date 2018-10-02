Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D58C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A542089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AQKG8+Yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A542089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJBRgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:36:38 -0400
Received: from mail-bl2nam02on0056.outbound.protection.outlook.com ([104.47.38.56]:15721
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726989AbeJBRgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfc6lBPQAgVXNY+EodKYfyE6iis7fcqxWEduvDLBpuo=;
 b=AQKG8+Yvg84MEy6RKm2KR20WLnj0zcwX0lWwfzGC+tHIE3Ih957xbeavMlMYjXq3voPyKbl7nSgaCxoYtBfoJCwGxuMnJLP9C+yCP24pM5Nb/HOOdoENBkzhd1JRN5UGCyy+eqmL6Sx20i6mkWkuPOgIg5pnqInBVDDHkaJmvH0=
Received: from BL0PR02CA0099.namprd02.prod.outlook.com (2603:10b6:208:51::40)
 by DM6PR02MB4475.namprd02.prod.outlook.com (2603:10b6:5:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.23; Tue, 2 Oct
 2018 10:53:38 +0000
Received: from SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BL0PR02CA0099.outlook.office365.com
 (2603:10b6:208:51::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1185.25 via Frontend
 Transport; Tue, 2 Oct 2018 10:53:37 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lixom.net; dkim=none (message not signed)
 header.d=none;lixom.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT008.mail.protection.outlook.com (10.152.72.119) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Tue, 2 Oct 2018 10:53:36 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g7IJ6-0004As-4p; Tue, 02 Oct 2018 03:53:36 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g7IJ1-0004Ap-0u; Tue, 02 Oct 2018 03:53:31 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w92ArSM0005493;
        Tue, 2 Oct 2018 03:53:28 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g7IIy-0004AX-AI; Tue, 02 Oct 2018 03:53:28 -0700
Subject: Re: [PATCH v3 2/4] firmware: xilinx: Add zynqmp IOCTL API for device
 control
To:     Olof Johansson <olof@lixom.net>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Jolly Shah <JOLLYS@xilinx.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1537985581-32164-1-git-send-email-jollys@xilinx.com>
 <1537985581-32164-3-git-send-email-jollys@xilinx.com>
 <CAOesGMhEcMB4caAPtCSq-m5zQBDc-8Z4f_xAkomnEwVaHyX2Mw@mail.gmail.com>
 <BL2PR02MB21308D0B6AF76A8094E70863B8EC0@BL2PR02MB2130.namprd02.prod.outlook.com>
 <CAOesGMiUnVrnW1VDh1CKRKGpkwAC9G8tiHjpb+7bss6LpPWU-A@mail.gmail.com>
 <2350f5c3-b59e-b37b-c679-5b0a36f9a79c@xilinx.com>
 <CAOesGMixcQS605kmpW+n-yWBGWu4Dz5SXH396mrWCUfQjfcWcQ@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <3b9ddd6a-7965-af51-cae5-4135f34de6c4@xilinx.com>
Date:   Tue, 2 Oct 2018 12:53:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAOesGMixcQS605kmpW+n-yWBGWu4Dz5SXH396mrWCUfQjfcWcQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(346002)(2980300002)(438002)(199004)(189003)(51914003)(4326008)(426003)(26005)(77096007)(8936002)(31686004)(356003)(316002)(93886005)(64126003)(229853002)(106466001)(2906002)(65806001)(446003)(9786002)(5660300001)(47776003)(486006)(65956001)(44832011)(50466002)(81166006)(126002)(11346002)(2616005)(81156014)(65826007)(63266004)(6246003)(6666003)(58126008)(31696002)(336012)(110136005)(476003)(186003)(23676004)(2486003)(36386004)(478600001)(305945005)(217873002)(14444005)(106002)(230700001)(76176011)(8676002)(36756003)(53546011)(54906003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4475;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT008;1:CqQ79THk5IThYVlaYVSnWmqzgDs0575tqnm6nxZUzpdkwGsmEet4mNjZwKxD+j9Gyft02hQL1E1ah1+Q8+fk41Zd0+AN0zQcPhwyJrr8i49zh63BRJYqBBrVoAv9owE8
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd70ff3e-cb86-4d49-2318-08d628554e64
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4475;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4475;3:T+OmbgVRNUqLg4RWyY6X1FTJlG2AjgeVmC6I/xgPjIsFvAfXAcIRZClCISg5F1ZVvj/+Gh02M8crvdmljpICXgd0EzZiL2EaVSGIWGGTjrQtjcE+CW+AAmDw6nuKR8qxh3w65Yl5hiXZsghytg1Rm1YK83Fkk9t4ILaBKOUdkbISzfCEH3dyyMANK7k/lLpnlg/78ZeV31GtRlbhxbXjmwmlGDB6uOSdqE1tjkQYDKBjbIoEFIByNsOIg8qM4zxhtg9ivWu4zOIJR6x++jGaF6Es4blqrGbY/zp4HJ1r6IPCjrUmqvivliw9hX2uWsF6+8FO6aPxp2Ujn6kyTxAq+slvmvbZqzSQiN5w0uHYsDQ=;25:Xw4k45PJorun4C4MGTyLq6lUV3RmdBuhvwLKuftWAJiTsqtyM/c+WK0nYBq7IxH5PLc19c5gsWnLmqAn9Sx7kpnnjlzXaGcgzgG/XACD7Mju6i1BcLfUQZ6huM95ro3IKRbHZpArzqLkG/t0MvwfZdQvyguzzui+hsY4vOirxWPSkFrzS3TP6WFoZmSEdObPMelS0V41z2IdWJEdn9k/RRD4h2ukGzfYw5V1umd0glQjQbd6uwfa93Yx5QiUq/5EL/8YP7DPdWrXSFugxq6P9SLQJzvOwkd/1uB/rBVDjLpjBTmv34a/lwrMJXQ8EM6okrJrOpMrr+Y7/GwPZMyCzw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4475:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4475;31:vCbTjLGPjLztZJAj+UX0Ob8xNm33a4j1bCNYjPwkmFHFYP8N/Vu09imZXcnRbOGA93XJQgDO3altlwAbT7j5SKi7/ngroLZqDp0slRgpCWcq1eKOMlS3Qj2JsLFz9ccOgimV84hX/eCjFMHt2mQ8+bdS84fYzc/DZEkVZDlrWqy8modOFxGidOZ/8NMtK2pPboWWbw9DszgU2JBXSxwS4ri1NgDV9EQvz1Q+f24WwT0=;20:P7TIMH0AMPbeYHIGqx/SYgZnIVqghWfOVvZHIc4039tDr4WXyOBkNTLITvVs6jvWQ9ePINSeB85oCPYm2jVDQPs2vS3/onjSZ6a3tbsAlB0dM35t9jPG9uYgxhAAR/UWiCueE/jxZ0nA4VbpHlvpA++4/IHYiy/Ah4lBiA1NGoKbpJXxw/wyMjVnR9xrlzMo3rBMpmzcogLO5YjmIT24YSc96hcf1VTN3Alx/20eLXp/TWZ/HoMI0h3ESePauSQ3889POqRJ4WQcoJ+j3X+nbVSj+03p5QehcLL63SYxgy9odrqg1OedSbqfTiV7j/aA3as1RmIZuwh4Tt+VM2AMckBdcTfKQR7gwilZz1TmCCz4vOnnD7poTk5qR7H1wX0hr7RRGHj4wKicAGW8HtuXCoPdUoXtexxokPMpZKNX8phTYgMCKjhqvq8xXYnoRd5sUr56NrDcaMr+8x24dXi0XIE9DLpKP6WySqLq9lHE7/arh1qod7Qhu6ZyGIuqtRtO
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB44751BF09A1EC36CB9C12D54C6E80@DM6PR02MB4475.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:DM6PR02MB4475;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4475;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4475;4:soN3EYrC/5cpMI0XHaUIrYvmPBZlp6FkbeNDHjrcOEW8F01hJzJquHnYhuPy8SsDGL22bNg6GTX85iJpEntwkoK1NT1dvmnBn9BnpeoNLEdCncOpWGy/VX9aXxCqdRlmEpQnp2tpvub3s8YUxgER+LJ5eZW++Q3YbOfpOsUIJWLIbFJi1Ij94YZI64sjW/eLV6K1FI6ON0Dt22qU6AO27JL+8cUX7sK+Zh+ZQhHZ9eNyVNeibpf2PVMP4IRO9Zt474uuiixaPYD3nzB4pOagmjAR4Dkp1ZrTMF6sKmcpVriNMoGv889EEbV6Zjn1gQE5
X-Forefront-PRVS: 0813C68E65
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI0NDc1OzIzOlFwZTM3bm9VT0NQWG1GT2J3cW9ScFIwZE8w?=
 =?utf-8?B?MlpsUmt0MkFFNG9EdHZhQW84blJCSFhtRVEvdlB0WUFEbHZsNWZ1elFaUWJD?=
 =?utf-8?B?Vk01QTY5bkE2ZTVUWmFGaDhDeTdkdGJ3VDNqNFZvUTd3bGNXMS9vcngvMUtF?=
 =?utf-8?B?cTJCZkF4RlVJQXpTR3FSRXNZZjh5OXNGMW9DRElDM3MyaEJJeXkvVWVDUmxP?=
 =?utf-8?B?ZXlCU2hHazQ4WE5nN24vd0FvY0ZRZXRCbUQyeWFobE9ubmp3MTRmdm5rTThY?=
 =?utf-8?B?SFAyQzJBeFJqcDNqd0dPMnNMVnVPNUtaVys4NVg0Z1hIMjR3dXZzTlpTUktN?=
 =?utf-8?B?bE5rVklrWE5uMXpYazczWTg4WUdQRWlyZGMyOE1pVE1lN013NTdTZ2ZZOHNE?=
 =?utf-8?B?cTVZRXJhbHorN0l5a08xTnFDalZxK3JhU2JXbFZFdCtVNzd2ZFNKSmptZzNj?=
 =?utf-8?B?MGlTUXVyT0pnM2M3RHNPMmtWVytBc3VQbWppSVBhaS9SMU9NZnZzT05hZU1u?=
 =?utf-8?B?WHZINjhSQVBiZmI1K3FLZVlRQ0E3ZTI2RWRja0VESCtUTHNhV2hxWFFyYlNn?=
 =?utf-8?B?QXVrU3hQdmN5MzFxQUtjVHBtbHNwYWw3MVFlRFZQYS9PRnR6clVodGw1QW5L?=
 =?utf-8?B?WmJGZllpSHl4MnRYdEs3Z3ZBSDlOY1daZ1dmMXQ0U2tta3VTQTBjODNicjdv?=
 =?utf-8?B?RHpidXRGRHVmcUtQZlpuVmRHdUpMWkdxeTJka2Q2dXN3Y01YTGliTFMxSkVZ?=
 =?utf-8?B?SEtZSXlVV3pJT2hPa01rYmlGRjdBVlQrOHNPWWhFcExKSW5HV2lWRmxFaFZL?=
 =?utf-8?B?b1YvSFQ0YzRPRTh3N2hCVWdoQ3JaUzhwM1AvOTk4RXlmdGxwb1ltZitad05L?=
 =?utf-8?B?ZnFYL0xuYVVyUjdtK1hsQ2NXTkxKWXRVYm5oZXNrMU9sbXluVFBGN1JGQzFI?=
 =?utf-8?B?VWhGeFBIdVNIZWd1Wk5ZQ2xBVnl2dmlyRUxCVzI1MFBwaFc4elFoY01qaCtL?=
 =?utf-8?B?QXkvRG1TUTRwZmFVRWlhTTByeXJzbEROcEhLZzRsQUNXR05ZSkxSckt4MFNM?=
 =?utf-8?B?NkZjaVFCai9YaWxkWXVKZVNVYktKcWVTU1U0RCtIMWdmbFBmckc4L0JIR2Fq?=
 =?utf-8?B?aGRldmFvNVJ2WHRydVcvN21MclJodnE0TWc0bTZ1NnNZK0EzYU8xbmo5RWc5?=
 =?utf-8?B?VG5tZzhhRVdHYUd3NithWTJwUGNWY0VhdXNmenhlcXRGTTlVYnF6WDkrc2hk?=
 =?utf-8?B?TEFFdlBIOFFxL0NWRjRQZXVpK2NnbWM2YnhiZTdpczhkdmUxRm9GNm05T2tJ?=
 =?utf-8?B?cXQ2N2RkOHIrT0FmUmRhV1NBaHNUYURyRXpsMVhmVThBT0dzQ2ZINTVjaDUz?=
 =?utf-8?B?SUlzWGxYWnAzNWJtL3hES2FEaytzWkppN1ZydDlEcUg1Q3ZzSG9LMEpZZStO?=
 =?utf-8?B?RHR4UmdKcGdjZ1dwbDhoQjhrdmdrMWdIUHVEL2N1WWd0RDExWHNIbENhL2RD?=
 =?utf-8?B?NG01S0E5NGcrVkU1cXpHbzV0cXp6eU4zU2ZtSEdBckI2bWw0cGxzanh2UFVG?=
 =?utf-8?B?aExiQ1RrU0lYcHUwVW0zRkhiM09yeVhzMGxUS3l1Q3RTeFczaURDYTRSbXVT?=
 =?utf-8?B?VW5GbTRjQ09zSW81MEUvOEtuTGZaVHovbjgwaTlEVnZKSTJpYnRjMjNRUkY1?=
 =?utf-8?B?SmovQzdKdUZiaVBoazl6VEFzNEgzZ2IzMHk3WEtBbTk0WEpRUnlqd0UrZURQ?=
 =?utf-8?B?eW5kRHp2RkRvRDZJanRPVUwwd2JIU0Vjd2VNTUFkVHFoejZzSDVSaTNkc0lE?=
 =?utf-8?B?aVlwWXpwcXhDSk5OYksySVUxaFlTZWxIQXZZOEMrZlg4TGc9PQ==?=
X-Microsoft-Antispam-Message-Info: TjPgocUw1agEa0WxUmdelj0umqZe+CWJUPhd7jHPJlaMqQ4C5Yye/VRhNFW79+O8ueaUZjlq4yLRXSl4GqcOywu7kL15HRZ6nor+U++TKSpETmbhZoaUX/Z73G4yATUFli+PjV4hYcGmZrc6JO5kYDKJAoNeeM6Uw4igarn5kvgME3evEc0tOFtTMmrlEgBRTYmFWWaL/Dy72UfwyS9EmMSbYYEEjbRr7XmH8g1/idB/xDTvCihlZKOceWC7hZX0cGTt1MMD2qL9v8LiE0r8b2Ic7j0ax7Jp79q5BYzqd7IsUTG7oluuLFltD7gAqksG1Y+ifDCOZ53dcZbeleUTuDMrnzHXn4EcAB9q/S683yY=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4475;6:cQXDHaxFE8HZ1pra/aV4GfPF1mljk3gFheCe/G4UsJs6wB1MtsKNmor3p16ykT9wlgOP+eoms3PLdHlpU7WWW45flkBfk463lohinp9FjsPVaVhhHaU3o9U6sH6jlCXXkwdbsJPFI3KQO1aVW9yzug2yW5VHPl7/Nr4MaWY0v6Y5FXo+UnLSYCgKx6mUf+lwe6YJuZlhSPPMi/aXQg+Y9MJWbVI3s/9Bkklosshlh5AWzCfhZBZzWNfAIqNPb+l0VUaZ3nA8dAVbjOlsowyvkrihs+l7oX2DOuzSB3gpZq9qjXjgAKY0qQfapQQM8WMCwew44SWo7Nr0g69wDVmF25wc7IhxTz76++McrKgWaiL+B5XZQdHsm6dt/E390SAVnX18aIBGn7J3MnL6+o1JUrUuUN+KmSFNYhFfPJeQygsKG7sdFvKOq0qEc8ay4VRAKBC3CNU2eEWsVCsR6aLgaA==;5:CblhpRr50wNKUyMedmcY4P5G5Wygs7qLuY8WlZuZt4q68l52F5LfvOgdlOsBTtfxXsL3hposK1CQxXsR9y+dAe5Vdt47EjnyGwdtGDQXb3ifcizddAJCOOYmmdyscIg21eXXq29/Ms9LKVAgXo9RR36qteYa7nBnffvmRTIc4t0=;7:LAEKiPc99JWGm6yONpIwXvjsqe7ua4zzDGkXRuprjzVKBcbF07OXH0VNSr4DxKuRiuGGFjuu47BFpJNWFDwQ2bMOTN2hab2suK/EoCANYEX88fL7NDLhqc24EEmEVcehfmoR6mAjsb5UhuWHLG6p5gsFhePxBT8kwCypVsWZl1vkBFXg3GutbeKpn1Rioyep7zUsBArDFbUBxTuQX4kcYxLxUrsJccftAwD18YiYHZNv8uyXG9O7KhhYscueFOX8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2018 10:53:36.8895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd70ff3e-cb86-4d49-2318-08d628554e64
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4475
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.10.2018 19:26, Olof Johansson wrote:
> On Mon, Oct 1, 2018 at 6:17 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> Hi,
>>
>> On 28.9.2018 23:12, Olof Johansson wrote:
>>> On Fri, Sep 28, 2018 at 10:15 AM Jolly Shah <JOLLYS@xilinx.com> wrote:
>>>>
>>>> Hi Olof,
>>>>
>>>> Thanks for the review. Pushed v4 with suggested fixes. Let us know if series looks good and we can create pull request for same.
>>>>
>>>> Thanks,
>>>> Jolly Shah
>>>
>>> I'm happy with this one, thanks for revising the patchset with the fixes.
>>>
>>> Feel free to add:
>>>
>>> Acked-by: Olof Johansson <olof@lixom.net>
>>>
>>> to the patches.
>>
>> Just for clarification. I have checked driver/clk and patches should
>> still go via Michael or Stephen.
>> Firmware code is already in arm-soc tree that's why I would expect
>> Michael/Stephen should review it and then it shouldn't be a problem to
>> take this via arm-soc tree.
>>
>> Olof: Please correct me if I am wrong and you are happy to take it via
>> arm-soc directly.
> 
> Honestly it might be easiest for you to prepare one branch and send to
> all parties in case you have contents you expect to go on top, but
> besides that I'd be fine with merging through either tree.

ok.

Stephen: Can you please take a look at 4/4?
dt binding was already reviewed that's when we have ACK from 4/4 I will
prepare that branch.

Thanks,
Michal
