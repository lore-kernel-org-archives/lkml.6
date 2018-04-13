Return-Path: <maier@linux.ibm.com>
X-Google-Smtp-Source: AIpwx4+vLE6UAepunz4EzececgpxqY0UWv8Al68gFufb7hTgirk6cU+M5B+2c+6DZk2+uhIJFUxG
ARC-Seal: i=1; a=rsa-sha256; t=1523637394; cv=none;
        d=google.com; s=arc-20160816;
        b=zxvFBILKZYw3hY5JuKqax+BhG7qMdAbVfz73PEWhAUdlQ+XHBxUt/19X+RuzYftgsk
         8ie7DZ0brTZT9ORuiawerHhfqYE04NJ4htqai7chJeWTGz94SmRkpBfoLrKkp+y/89YF
         y/83WnFsM1DKy/q6t4js435Wjl8vTd2+2bxxjzzPzCNtTdyL6uTV/slJiPBasGhYfwZc
         ZgrOpV3it9W9DODX2dzTBbwh0UxrqT403+NJDxbFlz1/5n4n/T5oM/QDKqAR46glZj3J
         +4S+sHh4lwrg5hcGS2Bpl6STRlfPUKi0LON571zxnRlaN0+wWhYDdkvonaNbb0E2CDCj
         0exg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=uva7p9p3WKnFtPD3c2luwKxoxLPCIDt1wwuPDknrx2A=;
        b=IxXSmMh+wTCDTZLjyLe16vMU2Q+QnTdSvo2rnlZR4ICTy38vrRxAJTfnlrYzHT0pN7
         HjF9CYPlcpALgXIulyDDetOW0kEB333ZNKoM2CkHAD45DgYM3wbRrFtJMtLPkbOxSCMr
         PTvhEsDNFkJb85AvubASadwZ9QTGOAo+OfMqRX90xcalDxkMPMxVbzyFU4A69Vgzbwqw
         yGw7WyjHq+bvjL6qohDIf0Wq+/ZR/SnxIzzkKgTjxTFF874AjoT3BELdu+R0xMKlI1ZK
         D7v66i04zKP3s3LsRUxUq0wUuhpJwUO+Bwwlgui6KosEvgjsqy+rjPs4Z9NQsbIuMqIN
         9pPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Steffen Maier <maier@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizefan@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH v2 0/2] tracing/events: block: bring more on a par with blktrace
Date: Fri, 13 Apr 2018 18:36:20 +0200
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18041316-0008-0000-0000-000004EA49D4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041316-0009-0000-0000-00001E7E5897
Message-Id: <20180413163623.11282-1-maier@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130152
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597636479596160991?=
X-GMAIL-MSGID: =?utf-8?q?1597649604336437050?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I had the need to understand I/O request processing in detail.
But I also had the need to enrich block traces with other trace events
including my own dynamic kprobe events. So I preferred block trace events
over blktrace to get everything nicely sorted into one ftrace output.
However, I missed device filtering for (un)plug events and also
the difference between the two flavors of unplug.

The first two patches bring block trace events closer to their
counterpart in blktrace tooling.

The last patch is just an RFC. I still kept it in this patch set because
it is inspired by PATCH 2/2.

Changes since v1:
[PATCH v2 1/2]
Use 0 and 1 instead of false and true for __print_symbolic table.
Now "trace-cmd report" can decode it. [Steven Rostedt]

Steffen Maier (3):
  tracing/events: block: track and print if unplug was explicit or
    schedule
  tracing/events: block: dev_t via driver core for plug and unplug
    events
  tracing/events: block: also try to get dev_t via driver core for some
    events

 include/trace/events/block.h | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

-- 
2.13.5
