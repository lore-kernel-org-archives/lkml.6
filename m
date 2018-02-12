Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753883AbeBLSN2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:13:28 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57109 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753334AbeBLSN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:13:26 -0500
X-IronPort-AV: E=Sophos;i="5.46,503,1511798400";
   d="scan'208";a="71751855"
Subject: Re: UFS writing request failure handling
To: "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <2a98182c0eed4f0d9615982dc3733024@SIWEX5A.sing.micron.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <f81bf6c9-fe46-344a-15cb-03867c9e7c6c@wdc.com>
Date: Mon, 12 Feb 2018 10:13:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2a98182c0eed4f0d9615982dc3733024@SIWEX5A.sing.micron.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/18 04:21, Bean Huo (beanhuo) wrote:
> I am looking at UFS error handling, but I didn't notice re-issues
> requests with UTP error to the host controller. According UFS host
> spec, "host software either completes the request that had the error
> and requests still outstanding with error to higher level software,
> or re-issues these requests to the host controller". For the latest
> Linux UFS driver, it belongs to former one? If I am wrong, please
> correct me.

Hello Bean,

I'm afraid that reissuing a failed write forever could cause an infinite 
loop that makes e.g. user space processes unkillable or that could cause 
an orderly system shutdown to hang. I'm not sure that we want such behavior.

If you want to learn more about how the SCSI core handles failed writes, 
please have a look at scsi_decide_disposition(). A possible approach to 
modify the error handling behavior is to stack a dm driver on top of the 
SCSI core that implements the desired behavior.

Bart.
