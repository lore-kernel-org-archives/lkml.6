Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964995AbeBMPSj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:18:39 -0500
Received: from mailout.micron.com ([137.201.242.129]:35800 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964851AbeBMPSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:18:37 -0500
From: "Bean Huo (beanhuo)" <beanhuo@micron.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: UFS writing request failure handling
Thread-Topic: UFS writing request failure handling
Thread-Index: AdOk3edWZeWxY6ylQK2qYqplxbjt0g==
Date: Tue, 13 Feb 2018 15:18:32 +0000
Message-ID: <6adc73db15b84425805a6adc09c2bfcf@SIWEX5A.sing.micron.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.160.29.124]
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-23660.005
X-TM-AS-Result: No--17.397200-0.000000-31
X-TM-AS-MatchedID: 150567-700107-702020-706564-704496-704173-709584-705861-7
        00782-707163-139010-851106-700075-187067-702187-701298-848362-705969-860493
        -106580-707064-700019-700648-708060-703283-106230-706891-703264-700398-7117
        12-700556-700173-712032-700756-113666-703731-702638-148004-148046-148133-14
        8980-20043-42000-42003-29961
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
x-mt-checkinternalsenderrule: True
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1DFIjEo006170

Hi Bart
Thanks for your answer.
I looked at SCSI core source codes these days, UFS also follows SCSI core error handling.
There is already re-issue behavior, and assign 5 retries for each UFS request if there is error.

>
>On 02/12/18 04:21, Bean Huo (beanhuo) wrote
>> I am looking at UFS error handling, but I didn't notice re-issues
>> requests with UTP error to the host controller. According UFS host
>> spec, "host software either completes the request that had the error
>> and requests still outstanding with error to higher level software, or
>> re-issues these requests to the host controller". For the latest Linux
>> UFS driver, it belongs to former one? If I am wrong, please correct
>> me.
>
>Hello Bean,
>
>I'm afraid that reissuing a failed write forever could cause an infinite loop that
>makes e.g. user space processes unkillable or that could cause an orderly
>system shutdown to hang. I'm not sure that we want such behavior.
>
>If you want to learn more about how the SCSI core handles failed writes,
>please have a look at scsi_decide_disposition(). A possible approach to
>modify the error handling behavior is to stack a dm driver on top of the SCSI
>core that implements the desired behavior.
>
>Bart.
