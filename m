Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeBAQYS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:24:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:37737 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751567AbeBAQYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:24:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,444,1511856000";
   d="scan'208";a="14296841"
Subject: Re: [PATCHv1] dt-bindings: misc: add Intel Stratix10 service layer
 binding
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, richard.gong@intel.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1516735502-16745-1-git-send-email-richard.gong@linux.intel.com>
 <1516735502-16745-2-git-send-email-richard.gong@linux.intel.com>
 <20180130165713.nbib54mbj6fhofnt@rob-hp-laptop>
From: Richard Gong <richard.gong@linux.intel.com>
Message-ID: <28aee16e-0d30-ee01-d4ba-912e0bd8d43a@linux.intel.com>
Date: Thu, 1 Feb 2018 10:26:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180130165713.nbib54mbj6fhofnt@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/30/2018 10:57 AM, Rob Herring wrote:
> On Tue, Jan 23, 2018 at 01:25:02PM -0600, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Add a device tree binding for the Intel Stratix10 service layer driver
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>>   .../devicetree/bindings/misc/intel-service.txt     | 56 ++++++++++++++++++++++
>>   1 file changed, 56 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/intel-service.txt
>>
>> diff --git a/Documentation/devicetree/bindings/misc/intel-service.txt b/Documentation/devicetree/bindings/misc/intel-service.txt
>> new file mode 100644
>> index 0000000..254e4a1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/intel-service.txt
>> @@ -0,0 +1,56 @@
>> +Intel Service Layer Driver for Stratix10 SoC
>> +============================================
>> +Intel Stratix10 SoC is composed of a 64 bit quad-core ARM Cortex A53 hard
>> +processor system (HPS) and Secure Device Manager (SDM). When the FPGA is
>> +configured from HPS, there needs to be a way for HPS to notify SDM the
>> +location and size of the configuration data. Then SDM will get the
>> +configuration data from that location and perform the FPGA configuration.
>> +
>> +To meet the whole system security needs and support virtual machine requesting
>> +communication with SDM, only the secure world of software (EL3, Exception
>> +Layer 3) can interface with SDM. All software entities running on other
>> +exception layers must channel through the EL3 software whenever it needs
>> +service from SDM.
>> +
>> +Intel Stratix10 service layer driver, running at privileged exception level
>> +(EL1, Exception Layer 1), interfaces with the service providers and provides
>> +the services for FPGA configuration, QSPI, Crypto and warm reset. Service layer
>> +driver also manages secure monitor call (SMC) to communicate with secure monitor
>> +code running in EL3.
>> +
>> +Required properties:
>> +--------------------
>> +The following are the mandatory properties:
>> +
>> +- compatible:
>> +		"intc,svc-1.0"
>> +- method:
>> +		smc or hvc
>> +			smc - Secure Monitor Call
>> +			hvc - Hypervisor Call
> Do you really need to support hvc or you are just copying and pasting
> from other implementations?
Thanks for the review.
Yes, We need to support hvc.
>
>> +- memory-region:
>> +		phandle to the reserved memory node. See
>> +		Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>> +		for details
> Please also put the svc node under the /firmware node and state that in
> the binding.
Sure, I will fix that in the next version.

Regards,
Richard
>
>> +
>> +Example:
>> +--------
>> +
>> +	reserved-memory {
>> +                #address-cells = <2>;
>> +                #size-cells = <2>;
>> +                ranges;
>> +
>> +                service_reserved: svcbuffer@0 {
>> +                        compatible = "shared-dma-pool";
>> +                        reg = <0x0 0x0 0x0 0x1000000>;
>> +                        alignment = <0x1000>;
>> +                        no-map;
>> +                };
>> +        };
>> +
>> +	svc {
>> +		compatible = "intc,svc-1.0";
>> +		method = "smc";
>> +		memory-region = <&service_reserved>
>> +	};
>> -- 
>> 2.7.4
>>
