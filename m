Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbeEGWft (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 18:35:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40978 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752884AbeEGWfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 18:35:46 -0400
Subject: Re: [PATCH] PCI/AER: add pcie TLP header information in the
 tracepoint
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
References: <20180402154708.5032-1-thomas.tai@oracle.com>
 <20180507222136.GD161390@bhelgaas-glaptop.roam.corp.google.com>
From: Thomas Tai <thomas.tai@oracle.com>
Organization: Oracle Corporation
Message-ID: <56c74c13-8a87-bec4-3f50-423a4699af6f@oracle.com>
Date: Mon, 7 May 2018 18:35:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507222136.GD161390@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805070220
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-05-07 06:21 PM, Bjorn Helgaas wrote:
> [+cc Steve, Alex]
> 
> On Mon, Apr 02, 2018 at 11:47:08AM -0400, Thomas Tai wrote:
>> When a PCIe AER occurs, the TLP header information is
>> printed in the kernel message but it is missing from
>> the tracepoint. A userspace program can use this information
>> in the tracepoint to better analyze problems.
>>
>> Example tracepoint output:
>> aer_event: 0000:01:00.0
>> PCIe Bus Error: severity=Uncorrected, non-fatal, Completer Abort
>> TLP Header={0x0,0x1,0x2,0x3}
>>
>> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> 
> I tentatively applied this to pci/aer for v4.18, thanks!

Thank you very much Bjorn!

Thomas

> 
> Steve, let me know if you have any comments.
> 
> Alex, I just copied you because you've been unifying the AER native and
> CPER paths, and this is another case of code that appears in both paths.
> FYI only, no action required :)
> 
>> ---
>>   drivers/pci/pcie/aer/aerdrv_errprint.c |  4 ++--
>>   include/ras/ras_event.h                | 20 ++++++++++++++++----
>>   2 files changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> index 6a352e638699..0a78a773bd25 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> @@ -192,7 +192,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>   		pci_err(dev, "  Error of this Agent(%04x) is reported first\n", id);
>>   
>>   	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
>> -			info->severity);
>> +			info->severity, info->tlp_header_valid, &info->tlp);
>>   }
>>   
>>   void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
>> @@ -252,6 +252,6 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>>   		__print_tlp_header(dev, &aer->header_log);
>>   
>>   	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>> -			aer_severity);
>> +			aer_severity, tlp_header_valid, &aer->header_log);
>>   }
>>   #endif
>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
>> index 9c689868eb4d..90f59556f595 100644
>> --- a/include/ras/ras_event.h
>> +++ b/include/ras/ras_event.h
>> @@ -298,30 +298,42 @@ TRACE_EVENT(non_standard_event,
>>   TRACE_EVENT(aer_event,
>>   	TP_PROTO(const char *dev_name,
>>   		 const u32 status,
>> -		 const u8 severity),
>> +		 const u8 severity,
>> +		 const u32 tlp_header_valid,
>> +		 struct aer_header_log_regs *tlp),
>>   
>> -	TP_ARGS(dev_name, status, severity),
>> +	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
>>   
>>   	TP_STRUCT__entry(
>>   		__string(	dev_name,	dev_name	)
>>   		__field(	u32,		status		)
>>   		__field(	u8,		severity	)
>> +		__field(	u32, 		tlp_header_valid)
>> +		__array(	u32, 		buf, 4		)
>>   	),
>>   
>>   	TP_fast_assign(
>>   		__assign_str(dev_name, dev_name);
>>   		__entry->status		= status;
>>   		__entry->severity	= severity;
>> +		__entry->tlp_header_valid = tlp_header_valid;
>> +		__entry->buf[0] = tlp->dw0;
>> +		__entry->buf[1] = tlp->dw1;
>> +		__entry->buf[2] = tlp->dw2;
>> +		__entry->buf[3] = tlp->dw3;
>>   	),
>>   
>> -	TP_printk("%s PCIe Bus Error: severity=%s, %s\n",
>> +	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
>>   		__get_str(dev_name),
>>   		__entry->severity == AER_CORRECTABLE ? "Corrected" :
>>   			__entry->severity == AER_FATAL ?
>>   			"Fatal" : "Uncorrected, non-fatal",
>>   		__entry->severity == AER_CORRECTABLE ?
>>   		__print_flags(__entry->status, "|", aer_correctable_errors) :
>> -		__print_flags(__entry->status, "|", aer_uncorrectable_errors))
>> +		__print_flags(__entry->status, "|", aer_uncorrectable_errors),
>> +		__entry->tlp_header_valid ?
>> +			__print_array(__entry->buf, 4, sizeof(unsigned int)) :
>> +			"Not available")
>>   );
>>   
>>   /*
>> -- 
>> 2.14.1
>>
