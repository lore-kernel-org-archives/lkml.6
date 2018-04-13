Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AIpwx49fiHgYrJhthlk3aJFHjtKuK8xwqlcKE9gijYrBQefil6xQ0g+9VuM/VsV1eIHQuOgIJSda
ARC-Seal: i=1; a=rsa-sha256; t=1523635187; cv=none;
        d=google.com; s=arc-20160816;
        b=XRD+TAfutCsL895Hyy5QPcPmZMynv6y58fqc9nWFEYNtVb7w8ooJ33EVLujqIiPMxZ
         AEPn1b+iTNZrMhNSKCLlcuO1b431Diy/n9BuTzI2f/rnDfqUMNwQPN+k4UuPf+s1PZzQ
         /jXSKu+sOkI3AqA2ML+X8xWwS3O/NWHDVnmlVJRiBnljZtG5P9pUoEf19wBLBR0nG6QT
         0tevCJ6gldcKioQLw342AzGDqqNYjryN6mewxLnHyGYCNeJ7ovFlJt9Lx8BMT3aaQm1D
         vx67CYCKaZQ4PaBGK/BoHn5luOCIFx1iSCOkp8pUhJJEk+tmFRX0PCJnptrXdsTupz1f
         Ey/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=hCVNi4tAmyDAkdMZFyUtrVFJ9tk/l+ptldz1HWN/zns=;
        b=fPB81usgvHGnl0HeWQ3mhzNMBBwxXtAigOTwbAV2M/bDPINDaGU5K4hBFA2HrX+lzy
         kRlsS4m72GfyzwZAttk06/+EANqBuwSBxwTIYfEYxCn34AYjAMMF4fCwe/mZT28sB+d4
         nIVvFguhh29LQHIpcqBjMFyW/sRea7VXYsWawFQAl5mdu/sdQ5OzaLJPxzPoEXZKs7Dq
         9Oweegkc3br5nrrTlHUfYWs+EK1oW4llhlwNVwh3zi8l0KAdLX1wnA2xXfCBI0rzsinv
         wNcm/rONk2V3nEdcbvMRdA6b7uS5taNnLPmu9STeOQ2JmggHohG5jpyZSYjbaAAdk2Iv
         m/Ew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Fri, 13 Apr 2018 17:59:43 +0200
From: Michal Hocko <mhocko@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Ingo Molnar <mingo@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Reza Arbab <arbab@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH RFC 7/8] mm: allow to control onlining/offlining of
 memory by a driver
Message-ID: <20180413155943.GY17484@dhcp22.suse.cz>
References: <20180413131632.1413-1-david@redhat.com>
 <20180413133334.3612-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413133334.3612-1-david@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597638095318503698?=
X-GMAIL-MSGID: =?utf-8?q?1597647290316104488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 13-04-18 15:33:28, David Hildenbrand wrote:
> Some devices (esp. paravirtualized) might want to control
> - when to online/offline a memory block
> - how to online memory (MOVABLE/NORMAL)
> - in which granularity to online/offline memory
> 
> So let's add a new flag "driver_managed" and disallow to change the
> state by user space. Device onlining/offlining will still work, however
> the memory will not be actually onlined/offlined. That has to be handled
> by the device driver that owns the memory.

Is there any reason to create the memblock sysfs interface to this
memory at all? ZONE_DEVICE mem hotplug users currently do not do that
and manage the memory themselves. It seems you want to achieve the same
thing, no?
-- 
Michal Hocko
SUSE Labs
