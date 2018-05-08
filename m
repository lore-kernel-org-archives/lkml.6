Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754754AbeEHNZM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:25:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34890 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeEHNZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:25:10 -0400
Subject: Re: [PATCH] PCI/AER: add pcie TLP header information in the
 tracepoint
To: Steven Rostedt <rostedt@goodmis.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>
References: <20180402154708.5032-1-thomas.tai@oracle.com>
 <20180507222136.GD161390@bhelgaas-glaptop.roam.corp.google.com>
 <20180508090756.57f38d17@gandalf.local.home>
From: Thomas Tai <thomas.tai@oracle.com>
Organization: Oracle Corporation
Message-ID: <a5578a08-2434-af48-7910-6f858e5477d6@oracle.com>
Date: Tue, 8 May 2018 09:25:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508090756.57f38d17@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080129
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ ... ]
>>> --- a/include/ras/ras_event.h
>>> +++ b/include/ras/ras_event.h
>>> @@ -298,30 +298,42 @@ TRACE_EVENT(non_standard_event,
>>>   TRACE_EVENT(aer_event,
>>>   	TP_PROTO(const char *dev_name,
>>>   		 const u32 status,
>>> -		 const u8 severity),
>>> +		 const u8 severity,
>>> +		 const u32 tlp_header_valid,
>>> +		 struct aer_header_log_regs *tlp),
>>>   
>>> -	TP_ARGS(dev_name, status, severity),
>>> +	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
>>>   
>>>   	TP_STRUCT__entry(
>>>   		__string(	dev_name,	dev_name	)
>>>   		__field(	u32,		status		)
>>>   		__field(	u8,		severity	)
>>> +		__field(	u32, 		tlp_header_valid)
> 
> I'm guessing tlp_header_valid is just a boolean. It's after severity
> which is just one byte long. Why not make this one byte as well,
> otherwise you are wasting 3 bytes.

Thanks Steven. Yes boolean is fine.

> 
> 
>>> +		__array(	u32, 		buf, 4		)
>>>   	),
>>>   
>>>   	TP_fast_assign(
>>>   		__assign_str(dev_name, dev_name);
>>>   		__entry->status		= status;
>>>   		__entry->severity	= severity;
>>> +		__entry->tlp_header_valid = tlp_header_valid;
> 
>>> +		__entry->buf[0] = tlp->dw0;
>>> +		__entry->buf[1] = tlp->dw1;
>>> +		__entry->buf[2] = tlp->dw2;
>>> +		__entry->buf[3] = tlp->dw3;
> 
> Should this assignment be dependent on whether or not tlp_header_valid
> is true? Could tlp be pointing to some random memory if it isn't? What
> about:

Good catch! will do so.

> 
> 	if ((__entry->tlp_header_valid = tlp_header_valid)) {
> 		__entry->buf[0] = tlp->dw0;
> 		__entry->buf[1] = tlp->dw1;
> 		__entry->buf[2] = tlp->dw2;
> 		__entry->buf[3] = tlp->dw3;
> 	}
> 
> 
>>>   	),
>>>   
>>> -	TP_printk("%s PCIe Bus Error: severity=%s, %s\n",
>>> +	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
>>>   		__get_str(dev_name),
>>>   		__entry->severity == AER_CORRECTABLE ? "Corrected" :
>>>   			__entry->severity == AER_FATAL ?
>>>   			"Fatal" : "Uncorrected, non-fatal",
>>>   		__entry->severity == AER_CORRECTABLE ?
>>>   		__print_flags(__entry->status, "|", aer_correctable_errors) :
>>> -		__print_flags(__entry->status, "|", aer_uncorrectable_errors))
>>> +		__print_flags(__entry->status, "|", aer_uncorrectable_errors),
>>> +		__entry->tlp_header_valid ?
>>> +			__print_array(__entry->buf, 4, sizeof(unsigned int)) :
> 
> Note, "sizeof" will be shown in the format file that perf and trace-cmd
> read to parse this event. They currently do not know how to parse that
> (although I could add that in the future).
> 
> Since sizeof(unsigned int) is always 4 in Linux, just use 4.

Yes, I will make the aboves changes and send out V2 patch. Thank you for 
your time and comments.

Thomas

> 
> 			__print_array(__entry->buf, 4, 4)
> 
> -- Steve
> 
> 
>>> +			"Not available")
>>>   );
>>>   
>>>   /*
>>> -- 
>>> 2.14.1
>>>    
> 
